
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;

import '../../pages/screens.dart';
import '../../utils/api_config.dart';
import 'exception.dart';

class ApiClient extends GetConnect implements GetxService{
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    // token = sharedPreferences.getString(ApiConfig.token);


    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // _mainHeaders = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Authorization': 'Bearer $token',
    // };
  }

  void updateHeader(String? token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> postData(
      String uri,
      dynamic body, {
        Map<String, dynamic>? query,
        String? contentType,
        Map<String, String>? headers,
        Function(dynamic)? decoder,
        Function(double)? uploadProgress,
      }) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> GetX Call: $uri\nToken: $token');
        debugPrint('====> GetX Body: $body');
      }

      DateTime time = DateTime.now();
      var loggerRespRcvTime = time.millisecondsSinceEpoch;
      Response response = await post(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );

      var link =  baseUrl.toString()  + uri + query.toString();

      // Get.find<LoggerController>().
      // saveLog(link, response.statusCode ?? -10  ,response: response.bodyString , isTimeOut: false ,
      //     loggerRespSendTime: loggerRespRcvTime , reqType: "GET" );

      response = handleResponse(response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if (_response.hasError &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorClass _errorResponse = ErrorClass.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors![0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.hasError && _response.body == null) {
      _response = const Response(
          statusCode: 0,
          statusText: 'Connection lost due to internet connection');
    }
    return _response;
  }

  Future<Response> getData(
      String uri, {
        Map<String, dynamic>? query,
        String? contentType,
        Map<String, String>? headers,
        Function(dynamic)? decoder,
      }) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> GetX Call: $uri\nToken: $token');
      }
      DateTime time = DateTime.now();
      var loggerRespRcvTime = time.millisecondsSinceEpoch;
      Response response = await get(
        uri,
        contentType: contentType,
        query: query,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
      );
      var link =  baseUrl.toString()  + uri + query.toString();
      // Get.find<LoggerController>().
      // saveLog(link, response.statusCode ?? -10  ,response: response.bodyString , isTimeOut: false ,
      // loggerRespSendTime: loggerRespRcvTime , reqType: "GET" );


      response = handleResponse(response);

      if (Foundation.kDebugMode) {
        debugPrint(
            '====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
        debugPrint(
            '====> GetX Response: [${_mainHeaders}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(
      String uri, {
        Map<String, dynamic>? query,
        String? contentType,
        Map<String, String>? headers,
        Function(dynamic)? decoder,
      }) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> GetX Call: $uri\nToken: $token');
      }
      DateTime time = DateTime.now();
      var loggerRespRcvTime = time.millisecondsSinceEpoch;
      Response response = await delete(
        uri,
        contentType: contentType,
        query: query,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
      );
      var link =  baseUrl.toString()  + uri + query.toString();
      // Get.find<LoggerController>().
      // saveLog(link, response.statusCode ?? -10  ,response: response.bodyString , isTimeOut: false ,
      // loggerRespSendTime: loggerRespRcvTime , reqType: "GET" );


      response = handleResponse(response);

      if (Foundation.kDebugMode) {
        debugPrint(
            '====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
        debugPrint(
            '====> GetX Response: [${_mainHeaders}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}