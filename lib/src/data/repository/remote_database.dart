import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:consultation_sdk/src/core/error/exception.dart';
import 'package:consultation_sdk/src/domain/repository/remote_database.dart';
import '../../core/utils.dart';

typedef DioCallClientMethod = dio.Response Function();

class RemoteDataSource extends RemoteDataSourceInit {
  final _className = 'RemoteDataSourceImpl';

  @override
  Future getRequest({required String url, Map<String, dynamic>? body, Map<String, dynamic>? customHeader}) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': Utils.getLoggedInUserToken(),
    };
    final uri = Uri.parse(url).replace(queryParameters: body);
    var dioClient = dio.Dio();
    final clientMethod = await dioClient.request(
      url,
      options: dio.Options(
        method: 'GET',
        headers: customHeader ?? headers,
        // contentType: 'application/json',
        validateStatus: (status) {
          return true;
        },
      ),
      queryParameters: body,
    );

    final responseJsonBody = await dioCallClientWithCatchException(
      () => clientMethod,
    );
    if (Utils.checkIsNull(responseJsonBody["success"]) || responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"] ?? "Something went wrong";
      throw UnauthorisedException(errorMsg, 410);
    } else {
      return responseJsonBody;
    }
  }

  @override
  Future<dynamic> postRequest({
    required Map<String, dynamic> body,
    required String url,
  }) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': Utils.getLoggedInUserToken(),
    };
    var dioClient = dio.Dio();
    final clientMethod = await dioClient.request(
      url,
      options: dio.Options(
        method: 'POST',
        headers: headers,
        contentType: 'application/json',
        validateStatus: (status) {
          return true;
        },
      ),
      data: json.encode(body),
    );

    final responseJsonBody = await dioCallClientWithCatchException(
      () => clientMethod,
    );
    if (Utils.checkIsNull(responseJsonBody["success"]) || responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"] ?? "Something went wrong";
      throw UnauthorisedException(errorMsg, 410);
    } else {
      return responseJsonBody;
    }
  }

  @override
  Future<dynamic> patchRequest({
    required Map<String, dynamic> body,
    required String url,
  }) async {
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      'Accept': 'application/json',
      'Authorization': Utils.getLoggedInUserToken(),
    };
    var dioClient = dio.Dio();
    final clientMethod = await dioClient.request(
      url,
      options: dio.Options(
        method: 'PATCH',
        headers: headers,
        // contentType: 'application/json',
        validateStatus: (status) {
          return true;
        },
      ),
      data: json.encode(body),
    );

    final responseJsonBody = await dioCallClientWithCatchException(
      () => clientMethod,
    );
    if (Utils.checkIsNull(responseJsonBody["success"]) || responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"] ?? "Something went wrong";
      throw UnauthorisedException(errorMsg, 410);
    } else {
      return responseJsonBody;
    }

    // return response.data;
  }

  @override
  Future<dynamic> deleteRequest({required String url}) async {
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      'Accept': 'application/json',
      'Authorization': Utils.getLoggedInUserToken(),
    };

    var dioClient = dio.Dio();
    final clientMethod = await dioClient.request(
      url,
      options: dio.Options(
        method: 'DELETE',
        headers: headers,
        // contentType: 'application/json',
        validateStatus: (status) {
          return true;
        },
      ),
    );

    final responseJsonBody = await dioCallClientWithCatchException(
      () => clientMethod,
    );
    if (Utils.checkIsNull(responseJsonBody["success"]) || responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"] ?? "Something went wrong";
      throw UnauthorisedException(errorMsg, 410);
    } else {
      return responseJsonBody;
    }
  }

  Future<dynamic> dioCallClientWithCatchException(
    DioCallClientMethod callClientMethod,
  ) async {
    try {
      final response = callClientMethod();
      return _dioResponseParser(response);
    } on SocketException {
      // log('SocketException', name: _className);
      throw const NetworkException(
        'Please check your \nInternet Connection',
        10061,
      );
    } on dio.DioException {
      ///503 Service Unavailable
      // log('http ClientException', name: _className);
      throw const NetworkException('Service unavailable', 503);
    } on FormatException {
      // log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on InternalServerException {
      // log('TimeoutException', name: _className);
      throw const InternalServerException('Request timeout', 500);
    } on TimeoutException {
      // log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  dynamic _dioResponseParser(dio.Response response) {
    switch (response.statusCode) {
      case 200:
        // var responseJson = json.decode(response.data);
        var responseJson = response.data;
        return responseJson;
      case 201:
        // var responseJson = json.decode(response.data);
        var responseJson = response.data;
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(json.encode(response.data));
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(json.encode(response.data));
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(json.encode(response.data));
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(json.encode(response.data));
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:
        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:
        /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');
      case 422:
        ///Unprocessable Entity
        final errorMsg = parsingError(response.data);
        throw InvalidInputException(errorMsg, 422);
      case 429:
        ///Unprocessable Entity
        final errorMsg = response.statusMessage ?? "Too many request";
        throw TooManyRequestException(errorMsg, 429);
      case 500:
        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        String errorMsg = "";
        if (response.data != null) {
          errorMsg = parsingError(response.data);
        } else {
          errorMsg = response.statusMessage ?? "";
        }
        throw FetchDataException(
          errorMsg.isNotEmpty ? errorMsg : 'Error occurred while communication with Server',
          response.statusCode!,
        );
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'].toString();
      }
    } catch (e) {
      // log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        // if(errorsMap["message"])
        return errorsMap['message'].toString();
      }
    } catch (e) {
      // log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }
}
