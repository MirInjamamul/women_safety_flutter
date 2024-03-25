import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/base_controller.dart';
import '../data/response/response_model.dart';
import '../pages/screens.dart';
import '../repositories/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  Future<ResponseModel> signUp(String email, String pwd, String userName, String mobile) async{
    BaseController().showLoading();
    update();
    ResponseModel responseModel;
    bool success = false;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pwd).then((response){
      debugPrint("::: Auth ::: New User Created");
      BaseController().hideLoading();
      update();

      success = true;

    }).onError((error, stackTrace){
      BaseController().hideLoading();
      update();

      success = false;
    });

    // Response response = await authRepo.signUp(email: email, password: pwd, username: userName, mobile: mobile);
    // ResponseModel responseModel;
    // if(response.statusCode == 200){
    //   Map map = response.body;
    //   authRepo.saveEmail(email);
    //   authRepo.setName(userName);
    //   authRepo.saveUserToken(map["token"]);
    //   authRepo.createChatUser(map);
    //   responseModel = ResponseModel(true, 'Login Success');
    // }else if(response.statusCode == 422 || response.statusCode == 302){
    //   responseModel = ResponseModel(false, 'The email has already been taken.');
    // }else{
    //   responseModel = ResponseModel(false, 'Internal Server Error');
    // }
    // BaseController().hideLoading();
    // update();
    return ResponseModel(success, "Unknown Error");
  }


  Future<ResponseModel> signIn(String email, String pwd) async{
    bool success = false;
    String message = "Unknown Error";

    BaseController().showLoading();
    update();


    // Response response = await authRepo.signIn(email: email);
    // ResponseModel responseModel;

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pwd).then((value){
      success = true;
      message = "Login Success";
    }).onError((error, stackTrace){
      success = false;
      message = "Login Failed";
    });

    // if(response.statusCode == 200){
    //   Map map = response.body;
    //   if(map['password'] == pwd){
    //     authRepo.saveEmail(email);
    //     authRepo.saveUserToken(map["token"]);
    //     setChatUserId(map['id'] + 1000);
    //     authRepo.setName(map["name"]);
    //     responseModel = ResponseModel(true, 'Login Success');
    //   }else{
    //     responseModel = ResponseModel(false, 'Wrong Password');
    //   }
    //
    //
    // }else if(response.statusCode == 422 || response.statusCode == 302){
    //   responseModel = ResponseModel(false, 'The email has already been taken.');
    // }else{
    //   responseModel = ResponseModel(false, 'Internal Server Error');
    // }

    BaseController().hideLoading();
    update();
    return ResponseModel(success, message);
  }

  int getVerificationCode() {
    return authRepo.getVerificationCode();
  }

  String getPhoneNumber(){
    return authRepo.getPhoneNumber();
  }

  String getEmail(){
    return authRepo.getEmail();
  }

  bool isLoggedIn(){
    return authRepo.isLoggedIn();
  }
  String getName(){
    return authRepo.getName();
  }
  Future<bool> setName(String name){
    return authRepo.setName(name);
  }

  Future<void> setChatUserId(int id) {
    return authRepo.setChatUserId(id);
  }
  int getChatUserId(){
    return authRepo.getChatUserId();
  }


  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

}