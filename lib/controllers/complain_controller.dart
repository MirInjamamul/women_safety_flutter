
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/response/response_model.dart';
import '../repositories/complain_repo.dart';

class ComplainController extends GetxController{
  final ComplainRepo complainRepo;
  ComplainController({required this.complainRepo});

  Future<ResponseModel> createComplain(String thana, String complainType, String comment)async{
    Response response = await complainRepo.createComplain(thana: thana, complain_type: complainType, comment: comment);
    ResponseModel responseModel;

    if(response.statusCode == 200){
      Map map = response.body;

      responseModel = ResponseModel(true, 'Complain Submitted');
    }else{
      responseModel = ResponseModel(false, 'Internal Server Error');
    }

    return responseModel;
  }



  // Future<ResponseModel> deleteComplain(int id)async{
  //   Response response = await complainRepo.deleteComplain(id);
  //   ResponseModel responseModel;
  //
  //   if(response.statusCode == 200){
  //     Map map = response.body;
  //
  //     responseModel = ResponseModel(true, 'Complain Submitted');
  //   }else{
  //     responseModel = ResponseModel(false, 'Internal Server Error');
  //   }
  //
  //   return responseModel;
  // }
}