import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:women_safety_flutter/data/error_model.dart';
import 'package:women_safety_flutter/services/network_connectivity_service.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage = 'Connection lost due to internet connection';
  static const String noResponse = 'Request Timeout';
  final int timeoutInSeconds = 30;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(ApiConfig.token);
    if(foundation.kDebugMode) {
      // debugPrint('Token: $token');
    }
    updateHeader(token);
  }

  void updateHeader(String? token) {
    Map<String, String> _header = {};
    _header.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    // debugPrint('>>>>>TOKEN$token');
    _mainHeaders = _header;
  }



  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    if(await isNetworkStable()){
      try {
        if(foundation.kDebugMode) {
          debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        }
        http.Response _response = await http.get(Uri.parse(appBaseUrl+uri), headers: headers ?? _mainHeaders,).timeout(Duration(seconds: timeoutInSeconds));
        return handleResponse(_response, uri);
      } catch (e) {
        return handleResponse(http.Response('', 405), uri);
        //return const Response(statusCode: 401, statusText: noResponse);
      }
    }else{
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers, int? timeout}) async {

    if(await isNetworkStable()){
      try {
        if(foundation.kDebugMode) {
          debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
          debugPrint('====> API Body: $body');
        }
        http.Response _response = await http.post(Uri.parse(appBaseUrl+uri), body: jsonEncode(body), headers: headers ?? _mainHeaders,).timeout(Duration(seconds: timeout ?? timeoutInSeconds));
        return handleResponse(_response, uri);
      } catch (e) {
        return handleResponse(http.Response('', 405), '');
        //return const Response(statusCode: 401, statusText: noResponse);
      }
    }else{
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response _response = await http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response _response = await http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }



  Future<Response> getOnlineRosterUsers(String userId)async{
    final response = await http.get(Uri.parse(ApiConfig.getOnlineRoster+userId));
    return Response(statusCode: response.statusCode, body: response.body);
  }

  Future<Response> getLastOnlineDetails(List<String> userIds)async{
    var requestBody  = jsonEncode({
      "userId": userIds
    });
    final response = await http.post(
        Uri.parse(ApiConfig.getLastOnlineRoster),
        headers: {"Content-Type": "application/json"},
        body: requestBody
    );

    return Response(statusCode: response.statusCode, body: response.body);
  }


  Future<Response> getBlockUserCheck(String userId, String blockId)async{
    var requestBody  = jsonEncode({
      "userId": userId,
      "blockId": blockId,
    });
    final response = await http.post(
        Uri.parse(ApiConfig.getBlockUserUri),
        headers: {"Content-Type": "application/json"},
        body: requestBody
    );

    return Response(statusCode: response.statusCode, body: response.body);
  }



  Future<Response> changeFollowStatus(String ownId, String followerId)async{
    var requestBody  = jsonEncode({
      "followerId": followerId
    });
    final response = await http.put(
        Uri.parse(ApiConfig.changeFollowUserUri+ownId),
        headers: {"Content-Type": "application/json"},
        body: requestBody
    );
    return Response(statusCode: response.statusCode, body: response.body);
  }

  Future<Response> blockChatUser(String userId, String blockedUserId) async{
    var requestBody = jsonEncode({
      "userId": userId,
      "blockId": blockedUserId
    });

    final response = await http.post(
        Uri.parse(ApiConfig.blockChatUserUri),
        headers: {"Content-Type": "application/json"},
        body: requestBody
    );

    print('----- $userId, $blockedUserId');

    return Response(statusCode: response.statusCode, body: response.body);

  }

  Future<Response> getBlockChatUser(String userId, String blockedUserId) async{
    var requestBody = jsonEncode({
      "userId": userId,
      "blockId": blockedUserId
    });

    final response = await http.post(
        Uri.parse(ApiConfig.getBlockByUri),
        headers: {"Content-Type": "application/json"},
        body: requestBody
    );

    return Response(statusCode: response.statusCode, body: response.body);

  }

  Future<Response> removeBlockChatUser(String userId, String blockedUserId) async{
    var requestBody = jsonEncode({
      "userId": userId,
      "blockId": blockedUserId
    });

    final response = await http.delete(
        Uri.parse(ApiConfig.deleteBlockUserUri),
        headers: {"Content-Type": "application/json"},
        body: requestBody
    );

    return Response(statusCode: response.statusCode, body: response.body);

  }

  Future<Response> getSuggestionList(String userId)async{
    final response = await http.get(Uri.parse(ApiConfig.getSuggestionRoster+userId));
    return Response(statusCode: response.statusCode, body: response.body);
  }

  // Future<Response> resetPassword(int userId, String newPassword) async {
  //   var chatBody = jsonEncode({
  //     "user": ApiConfig.xmppUserName+userId.toString(),
  //     "host": "unitedsportshub.com",
  //     "newpass": newPassword
  //   });
  //
  //   final response = await http.post(Uri.parse(ApiConfig.resetPassword),
  //       headers: {"Content-Type": "application/json"}, body: chatBody);
  //
  //   debugPrint('---GetX Response>>${response.body}');
  //   return Response(statusCode: response.statusCode, body: response.body);
  // }

  Timer? _timer;
  Response handleResponse(http.Response response, String uri) {
    Response _response;
    if(response.body.isNotEmpty){
      _response = Response(
        body: jsonDecode(response.body),
        bodyString: response.body.toString(),
        request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    }else{
      _response = Response(
        body: null,
        statusCode: response.statusCode,
      );
    }


   if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorClass _errorResponse = ErrorClass.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors![0].message);
      }else if(_response.body.toString().startsWith('message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = const Response(statusCode: 1005, statusText: noInternetMessage);
    }
    if(foundation.kDebugMode) {
      debugPrint('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }
}







