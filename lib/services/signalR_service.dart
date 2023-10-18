import 'package:logger/logger.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/signalR_controller.dart';
import 'package:women_safety_flutter/utils/api_config.dart';


class SignalRService{

  final Logger _logger = Logger();

  late HubConnection _hubConnection;

  // factory SignalRService(){
  //   return _instance;
  // }

  SignalRService(){
    _hubConnection = HubConnectionBuilder()
        .withUrl(ApiConfig.signalRUrl+ApiConfig.signalRChatHub)
        .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
        .build();

    _hubConnection.on("ReceiveMessage", (arguments) {
      _logger.d("signalR ReceiveMessage : $arguments");
      Get.find<SignalRController>().receivedMessage(arguments);
    });

    _hubConnection.on("ReceiveRequestMessage", (arguments) {
      _logger.d("signalR ReceiveRequestMessage : $arguments");
      Get.find<SignalRController>().receivedRequestMessage(arguments);
    });

    _hubConnection.on("ReceiveUser", (arguments) {
      _logger.d("Receive User: $arguments");
    });

    _hubConnection.on("ConnectionId", (arguments){
      if(arguments!.isNotEmpty){
        Get.find<SignalRController>().setNick(ApiConfig.userId.toString());
      }
    });

    _hubConnection.on("UserLogged", (arguments){
      _logger.d("SignalR Login : $arguments");
    });

    _hubConnection.on("UserLoggedOut", (arguments){
      _logger.d("SignalR Logout : $arguments");
    });

    _hubConnection.on("onlineUsers", (arguments){
      _logger.d("SignalR Current Online Users: $arguments");
      // Get.find<SignalRController>().setOnlineUser(arguments);
    });


    ///
    /// Live Match
    ///
    _hubConnection.on("ReceiveLiveInvitation", (arguments){
      _logger.d("signalR ReceiveInvitation : $arguments");
      Get.find<SignalRController>().showInvitationDialogue(arguments);
    });



    _hubConnection.onclose(({error}) {
      _logger.e("Connection Close: $error");
    });

    _startHubConnection();
  }

  HubConnection get hubConnection => _hubConnection;

  Future<void> _startHubConnection() async {
    try {
      await _hubConnection.start()?.then((value){
        // _hubConnection.invoke("GetConnectionId").then((value){
        //   // setConnectionString(value);
        //   // _logger.d("SignalR Connection Id : $value");
        //   //
        //   // Get.find<SignalRController>().setNick(Get.find<AuthController>().getUserId().toString());
        // });
      });

    } catch (e) {
      _logger.e("Error Connecting on Hub $e");
    }
  }

  // Future<void> reset() async{
  //   _hubConnection.stop();
  //
  //   _hubConnection = HubConnectionBuilder()
  //       .withUrl(ApiConfig.SignalRUrl+ApiConfig.SignalRChatHub)
  //       .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
  //       .build();
  //
  //   _startHubConnection();
  // }

  void dispose(){
    _logger.i("logout from Hub");
    _hubConnection.stop();
  }

}

