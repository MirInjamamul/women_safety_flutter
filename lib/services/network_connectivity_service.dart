import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

Future<bool> isNetworkStable() async {
  final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.none) {
    return false; /// No network connection
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty && response.first.rawAddress.isNotEmpty) {
        return true; /// Network connection is stable
      }
    } on PlatformException catch (e) {
      print('Error: $e');
      return false; /// Network connection is unstable
    }
  }

  return false; /// Default to network being unstable
}



class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    bool _firstTime = true;
    bool isNotConnected = false;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(!_firstTime) {
        isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
      }else{
        isNotConnected = false;
      }
      _firstTime = false;
    });
    return isNotConnected;
  }

  static void checkConnectivity() {
    bool _firstTime = true;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        if(!isNotConnected){
         // showCustomToast('connected');
        }
      }
      _firstTime = false;
    });
  }






  // static void checkConnectivity() {
  //   bool _firstTime = true;
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
  //     if(!_firstTime) {
  //       bool isNotConnected;
  //       if(result == ConnectivityResult.none) {
  //         isNotConnected = true;
  //       }else {
  //         isNotConnected = !await _updateConnectivityStatus();
  //       }
  //       showCustomToast(getTranslated(isNotConnected ? 'no_connection' : 'connected', Get.context!)!);
  //     }
  //     _firstTime = false;
  //   });
  // }

  Future<bool> _updateConnectivityStatus() async {
    bool _isConnected = false;
    try {
      final List<InternetAddress> _result = await InternetAddress.lookup('google.com');
      if(_result.isNotEmpty && _result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    }catch(e) {
      _isConnected = false;
    }
    return _isConnected;
  }
}


