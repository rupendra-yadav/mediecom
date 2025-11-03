import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mediecom/core/common/error/app_exceptions.dart';
import 'package:mediecom/core/utils/utils.dart';

import '../../../../core/constants/api_constants.dart';

import '../../../user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserDetails(String userId);
  Future<UserModel> updateProfile(
    String userId,
    Map<String, String> profileData,
  );
  Future<UserModel> updatePhoto(String userId, String photoPath);
  Future<void> updateFcm(String userId, String fcmToken);
  Future<List<Map<String, dynamic>>> getNotifications(String userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> fetchUserDetails(String userId) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.userDetails),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'user_id': userId},
      );

      _logApiCall('fetchUserDetails', response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          return UserModel.fromJson(responseBody['data'][0]);
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to fetch user details',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Server error',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfile(
    String userId,
    Map<String, String> profileData,
  ) async {
    try {
      final body = {'user_id': userId, ...profileData};
      final response = await client.post(
        Uri.parse(ApiConstants.updateProfile),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      _logApiCall('updateProfile', response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          return UserModel.fromJson(responseBody['data'][0]);
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to update profile',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Server error',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<UserModel> updatePhoto(String userId, String photoPath) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse(ApiConstants.updatePhoto))
            ..fields['user_id'] = userId
            ..files.add(await http.MultipartFile.fromPath('photo', photoPath));

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      _logApiCall('updatePhoto', response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          return UserModel.fromJson(responseBody['data'][0]);
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to update photo',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Server error',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<void> updateFcm(String userId, String fcmToken) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.updateFcm),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'user_id': userId, 'fcm_token': fcmToken},
      );

      _logApiCall('updateFcm', response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] != 'success') {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to update FCM token',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Server error',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.notification),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'user_id': userId},
      );

      _logApiCall('getNotifications', response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['response'] == 'success' &&
            responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];
          return List<Map<String, dynamic>>.from(data);
        } else {
          throw ServerException(
            message: responseBody['message'] ?? 'Failed to fetch notifications',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Server error',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'No internet connection', statusCode: 0);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _logApiCall(String method, http.Response response) {
    appLog('POST ${response.request?.url}');
    appLog('Method: $method');
    appLog('Status: ${response.statusCode}');
    appLog('Response: ${response.body}');
  }

  void _handleError(dynamic e) {
    if (e is ServerException) {
      throw e;
    } else {
      appLog('Unexpected error: $e');
      throw ServerException(
        message: 'Unexpected error occurred: ${e.toString()}',
        statusCode: 500,
      );
    }
  }
}
