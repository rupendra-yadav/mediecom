import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediecom/core/common/error/app_exceptions.dart';
import 'package:mediecom/core/utils/utils.dart';
import 'package:mediecom/features/explore/data/models/product_model.dart';

import '../../../../core/constants/api_constants.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({String? categoryId});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({String? categoryId}) async {
    try {
      final uri = Uri.parse(ApiConstants.product);
      final response = await client.post(
        uri,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: categoryId != null ? {'category_id': categoryId} : null,
      );

      appLog('POST ${ApiConstants.product}');
      appLog(
        'Request Body: ${categoryId != null ? {'category_id': categoryId} : {}}',
      );
      appLog('Response Status: ${response.statusCode}');
      appLog('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        // API uses 'response' == 'success' and contains 'data' similar to other endpoints
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          final List<dynamic> jsonResponse = responseBody['data'];
          return jsonResponse.map((e) => ProductModel.fromJson(e)).toList();
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to get products',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to get products',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      appLog('ProductRemoteDataSourceImpl exception: $e');
      throw ServerException(
        message: 'Unexpected error occurred',
        statusCode: 500,
      );
    }
  }
}
