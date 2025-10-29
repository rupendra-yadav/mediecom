import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mediecom/core/common/error/app_exceptions.dart';
import 'package:mediecom/features/master/data/models/category_model.dart';
import 'package:mediecom/features/master/data/models/slider_model.dart';

import '../../../../core/constants/api_constants.dart';

abstract class MasterRemoteDataSource {
  Future<List<SliderModel>> getBanners();

  Future<List<CategoryModel>> getCategory();

  // Future<List<NestedCategoryModel>> getNestedSubCategories();

  // Future<List<SubCategoryModel>> getSubCategory(String catId);
}

class MasterRemoteDataSourceImpl implements MasterRemoteDataSource {
  final http.Client client;

  MasterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SliderModel>> getBanners() async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.slider),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      log('GET ${ApiConstants.slider}');
      log(
        'Request Headers: ${json.encode({'Content-Type': 'application/x-www-form-urlencoded'})}',
      );
      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          final List<dynamic> jsonResponse = json.decode(response.body)['data'];
          return jsonResponse
              .map((json) => SliderModel.fromJson(json))
              .toList();
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to get data',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to get data',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error occurred',
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.category),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      log('GET ${ApiConstants.category}');
      log(
        'Request Headers: ${json.encode({'Content-Type': 'application/x-www-form-urlencoded'})}',
      );
      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          final List<dynamic> jsonResponse = json.decode(response.body)['data'];
          return jsonResponse
              .map((json) => CategoryModel.fromJson(json))
              .toList();
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to get data',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to get data',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error occurred',
        statusCode: 500,
      );
    }
  }

  // @override
  // Future<List<NestedCategoryModel>> getNestedSubCategories() async {
  //   try {
  //     final response = await client.post(
  //       Uri.parse(ApiConstants.getNestedSubCategories),
  //       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //     );

  //     log('GET ${ApiConstants.getNestedSubCategories}');
  //     log(
  //       'Request Headers: ${json.encode({'Content-Type': 'application/x-www-form-urlencoded'})}',
  //     );
  //     log('Response Status: ${response.statusCode}');
  //     log('Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseBody = json.decode(response.body);
  //       if (responseBody['response'] == 'success' &&
  //           responseBody.containsKey('data')) {
  //         final List<dynamic> jsonResponse = json.decode(response.body)['data'];
  //         return jsonResponse
  //             .map((json) => NestedCategoryModel.fromJson(json))
  //             .toList();
  //       } else {
  //         throw ServerException(
  //           message: responseBody['message'] ?? 'Failed to get data',
  //           statusCode: response.statusCode,
  //         );
  //       }
  //     } else {
  //       throw ServerException(
  //         message: 'Failed to get data',
  //         statusCode: response.statusCode,
  //       );
  //     }
  //   } on http.ClientException {
  //     throw NetworkException(message: 'No internet connection', statusCode: 0);
  //   } catch (e) {
  //     throw ServerException(
  //       message: 'Unexpected error occurred',
  //       statusCode: 500,
  //     );
  //   }
  // }

  // @override
  // Future<List<SubCategoryModel>> getSubCategory(String catId) async {
  //   try {
  //     final response = await client.post(
  //       Uri.parse(ApiConstants.getSubCategory),
  //       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //       body: {'category_id': catId},
  //     );

  //     log('GET ${ApiConstants.getSubCategory}');
  //     log(
  //       'Request Headers: ${json.encode({'Content-Type': 'application/x-www-form-urlencoded'})}',
  //     );
  //     log('Request Body: ${{'category_id': catId}}');

  //     log('Response Status: ${response.statusCode}');
  //     log('Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseBody = json.decode(response.body);
  //       if (responseBody['response'] == 'success' &&
  //           responseBody.containsKey('data')) {
  //         final List<dynamic> jsonResponse = json.decode(response.body)['data'];
  //         return jsonResponse
  //             .map((json) => SubCategoryModel.fromJson(json))
  //             .toList();
  //       } else {
  //         throw ServerException(
  //           message: responseBody['message'] ?? 'Failed to get data',
  //           statusCode: response.statusCode,
  //         );
  //       }
  //     } else {
  //       throw ServerException(
  //         message: 'Failed to get data',
  //         statusCode: response.statusCode,
  //       );
  //     }
  //   } on http.ClientException {
  //     throw NetworkException(message: 'No internet connection', statusCode: 0);
  //   } catch (e) {
  //     throw ServerException(
  //       message: 'Unexpected error occurred',
  //       statusCode: 500,
  //     );
  //   }
  // }
}
