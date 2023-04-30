import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/response/response_model.dart';
import '../repositories/auth_repo.dart';


class AuthController extends GetxController{
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  Future<ResponseModel> signUp(String email, String pwd, String userName, String mobile) async{
    Response response = await authRepo.signUp(email: email, password: pwd, username: userName, mobile: mobile);
    ResponseModel responseModel;
    if(response.statusCode == 200){
      Map map = response.body;
      // String token = map["token"];

      // authRepo.saveUserToken(token);
      authRepo.saveEmail(email);

      responseModel = ResponseModel(true, 'Login Success');
    }else if(response.statusCode == 422 || response.statusCode == 302){
      responseModel = ResponseModel(false, 'The email has already been taken.');
    }else{
      responseModel = ResponseModel(false, 'Internal Server Error');
    }

    return responseModel;
  }

  Future<ResponseModel> signIn(String email, String pwd) async{
    Response response = await authRepo.signIn(email: email);
    ResponseModel responseModel;
    if(response.statusCode == 200){
      Map map = response.body;
      // String token = map["token"];

      // authRepo.saveUserToken(token);

      if(map['password'] == pwd){
        authRepo.saveEmail(email);

        responseModel = ResponseModel(true, 'Login Success');
      }else{
        responseModel = ResponseModel(false, 'Wrong Password');
      }


    }else if(response.statusCode == 422 || response.statusCode == 302){
      responseModel = ResponseModel(false, 'The email has already been taken.');
    }else{
      responseModel = ResponseModel(false, 'Internal Server Error');
    }

    return responseModel;
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


}