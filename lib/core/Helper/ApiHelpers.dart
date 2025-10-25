import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mediecom/core/common/error/app_exceptions.dart';
import 'package:mediecom/core/constants/api_constants.dart';
import 'package:path/path.dart' as path;

class ApiHelpers {
  /// SQL QUERY
  Future<Map<String, dynamic>> sqlQuery({
    Map<String, dynamic> requestBody = const {},
    String type = "select",
  }) async {
    String endKey;

    switch (type) {
      case "insert":
        endKey = ApiConstants.insertData;
        break;
      case "select":
        endKey = ApiConstants.sqlexecc;
        break;
      case "update":
        endKey = ApiConstants.sqlexecc;
        break;
      default:
        endKey = ApiConstants.sqlexecc;
    }

    try {
      final response = await http.post(Uri.parse(endKey), body: requestBody);

      log("API URL: ${endKey}");
      log("Request: ${requestBody}");
      log("Status Code: ${response.statusCode}");
      log("Response: ${response.body}");

      if (response.statusCode == 200) {
        // ✅ Just return raw response string
        return {"response": response.body, "status": true};
      } else {
        throw ServerException(
          message: "Server error: ${response.body}",
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: "No Internet Connection", statusCode: 0);
    } catch (e, s) {
      log("Error in updateListing: $e\n$s");
      throw ServerException(
        message: 'Unexpected error occurred',
        statusCode: 500,
      );
    }
  }

  /// FILE UPLOAD
  Future<Map<String, dynamic>> uploadFile({
    required File file, // the file to upload
    Map<String, String> fields = const {}, // optional extra form fields
  }) async {
    try {
      // create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.uploadFile),
      );

      // add file
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // key the server expects
          file.path,
          filename: path.basename(file.path),
        ),
      );

      // add optional fields
      request.fields.addAll(fields);

      log("API URL: ${ApiConstants.uploadFile}");
      log("Uploading file: ${file.path}");
      log("Extra fields: $fields");

      // send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log("Status Code: ${response.statusCode}");
      log("Response: ${response.body}");

      if (response.statusCode == 200) {
        return {"response": response.body, "status": true};
      } else {
        throw ServerException(
          message: "Server error: ${response.body}",
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: "No Internet Connection", statusCode: 0);
    } catch (e, s) {
      log("Error in uploadFile: $e\n$s");
      throw ServerException(
        message: 'Unexpected error occurred',
        statusCode: 500,
      );
    }
  }
}
