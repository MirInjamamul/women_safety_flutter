import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:logger/logger.dart';
import 'package:women_safety_flutter/api_client.dart';
import 'package:women_safety_flutter/controllers/auth_controller.dart';
import 'package:women_safety_flutter/data/message_model.dart';
import 'package:women_safety_flutter/data/repo/signalR_repo.dart';
import 'package:women_safety_flutter/data/response_model.dart';
import 'package:women_safety_flutter/services/database_helper.dart';
import 'package:women_safety_flutter/services/signalR_service.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

class SignalRController extends GetxController implements GetxService{
  final SignalRepo signalRepo;
  late SignalRService signalRService;
  late HubConnection hubConnection;

  final Logger _logger = Logger();

  SignalRController({required this.signalRepo});

  Future<void> loginSignal() async {
    signalRService = SignalRService();
    hubConnection = signalRService.hubConnection;

  }

  Future<void> setNick(String nick) async{
    hubConnection = signalRService.hubConnection;
    signalRepo.setNick(hubConnection, nick);
    _logger.i("CloudSignal Nick Set $nick");
  }

  Future<void> sendMessage(String receiverId, String receiverUserName, String message, {bool isReply = false,bool isMe = true, int messageId = 0}) async {
    if(hubConnection.state != HubConnectionState.Connected){
      await loginSignal().then((value) {
        signalRepo.sendMessage(hubConnection, receiverId, message);
      });
    }

    signalRepo.sendMessage(hubConnection, receiverId, message);

    // TODO add a common fuction for insert into DB for both send and receiver message

    MessageModel messageModel = MessageModel(
      messageId: messageId,
      replyId: '',
      name: receiverUserName,
      photo: "",
      message: message,
      lastMessage: message,
      isActive: true,
      isSeen: true,
      isMe: isMe,
      messageType: 'text',
      withUserId: receiverId,
      toUserId: ApiConfig.adminId,
      mediaUrl: '',
      unreadMessageCount: 1,
      isRequest: false,
      isHide: false,
      isDeleteAccount: false,
      isBlockedByMe: false,
      isBlockedByYou: false,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );

    await DatabaseHelper.instance.insert(messageModel: messageModel);
    _messageList.add(messageModel);
    update();
  }

  void sendLiveMatchInvitation(
      String receiverUserId,
      int senderId,
      String name,
      String photo,
      String roomId)async{

    print("receiver Id $receiverUserId");

    if(hubConnection.state != HubConnectionState.Connected){
      await loginSignal().then((value) {
        signalRepo.sendLiveMatchInvitation(hubConnection, receiverUserId, senderId.toString(),name, photo, roomId);
      });
    }else{
      signalRepo.sendLiveMatchInvitation(hubConnection, receiverUserId, senderId.toString(), name, photo, roomId);
    }

  }

  void showInvitationDialogue(var arguments){

    if(arguments.isNotEmpty){
      Map<String, dynamic> data = arguments[0];
    //  signalRepo.showInvitationDialogue(data['roomId'], data['name'], data['photo']);

      // if(Get.find<PKController>().appInBackGroud == true){
      //   createLocalNotification("Live Match Invitation", 'You have got an invitation from ${data['name']}');
      // }
    }else{
      _logger.e("Invitation Arguments is Empty");
    }

  }

  List<MessageModel> _messageList = [];
  List<MessageModel> get messageList => _messageList;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getSingleMsgFromDB(String userId, bool reload) async{
    if (reload) {
      _messageList = [];
      _currentPage = 1;
      _isLoading = false;
      update();
    }
    _messageList = await DatabaseHelper.instance.getMessagesByUserId(userId, Get.find<AuthController>().getChatUserId().toString(), _currentPage, 15, reload);
    _currentPage++;
    _isLoading = false;
    update();
  }

  Future<void> updateMessageSeen(String withUserId)async{
    await DatabaseHelper.instance.updateIsSeen(withUserId);
  }

  Future<void> updateBlockedByMe(String toUserId, String withUserId, bool blocked)async{
    await DatabaseHelper.instance.updateBlockedByMe(toUserId, withUserId, blocked);
  }



  showLoader(){
    _isLoading = true;
    update();
  }

  void receivedMessage(var arguments) async{
    if(arguments.isNotEmpty){
      Map<String, dynamic> data = arguments[0];
      MessageModel messageModel = MessageModel(
        messageId: data["messageId"],
        name: data['senderUserName'],
        messageType: 'text',
        withUserId: data['senderId'],
        toUserId: Get.find<AuthController>().getChatUserId().toString(),
        mediaUrl: '',
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        message: data['message'],
        unreadMessageCount: 1,
        isRequest: false,
        isHide: false,
        isDeleteAccount: false,
        isActive: true,
        isMe: false,
        lastMessage: data['message'],
        photo: "",
        isSeen: false,
      );
      await DatabaseHelper.instance.insert(messageModel: messageModel);
      _messageList.add(messageModel);
      // print('--------->>>>><<<${Get.currentRoute}/${ModalRoute.of(context)?.settings.name}');
      if (!Get.currentRoute.contains('/InboxScreen')) {
        //createLocalNotification(messageModel.name!, messageModel.message!);
      }
      update();


      if(messageModel.message!.contains("/location")){
        getCurrentLocation(messageModel);

      }
    }
  }

  _triggerNotification(String title, String description){
    //createLocalNotification(title, description);
  }

  Future<bool> isUnreadMessage(String toUserId) async{
    return await DatabaseHelper.instance.getUnreadMessage(toUserId);
  }


  deleteSingleMsg(List<int> ids){
    for(var id in ids){
      _messageList.removeWhere((element) => element.messageId == id);
    }
    update();
  }

  deleteAllMsg(){
    _messageList = [];
    update();
  }

  final List<RosterModel> _rosterList = [];
  List<RosterModel> get rosterList => _rosterList;

  // void setOnlineUser(var arguments){
  //   _rosterList = [];
  //   if(arguments.isNotEmpty){
  //     var count = 0;
  //     for(var item in arguments[0]){
  //       count++;
  //       _rosterList.add(
  //           RosterModel(userId: item.toString(), userName: "user_${count}", photo: AllImages.profile)
  //       );
  //     }
  //   }
  //
  //   update();
  // }

  void getOnlineRosterUsers(String userId) async{
    Response response = await signalRepo.getOnlineRosterUsers(userId);
    if(response.statusCode == 200){
      _rosterList.clear();
      jsonDecode(response.body).forEach((roster){
        _rosterList.add(RosterModel.fromJson(roster));
      });
      update();
    }else{
      _logger.e(response.statusText);
    }
    update();
  }

  Future<List<RosterModel>> getLastOnlineRoster(List<String> userIds) async{
    Response response = await signalRepo.getLastOnline(userIds);
    List<RosterModel> _lastOnline = [];
    if(response.statusCode == 200){
      jsonDecode(response.body).forEach((roster){
        print("----- ${roster.toString()}");
        _lastOnline.add(RosterModel.fromJson(roster));
      });
    }else{
      _logger.e(response.statusText);
    }

    return _lastOnline;
  }

  Future<List<bool>> getBlockUserCheck(String userId, String blockId) async{
    Response response = await signalRepo.getBlockUserCheck(userId, blockId);
    List<bool> _isBlockList = [];
    if(response.statusCode == 200){
      jsonDecode(response.body).forEach((roster){
        print("----- _isBlockList ${roster.toString()}");
        _isBlockList.add(roster);
      });
    }else{
      _logger.e(response.statusText);
    }

    return _isBlockList;
  }



  Future<ResponseModel> changeFollowStatus(String ownUserId, String followerId) async{
    Response response = await signalRepo.changeFollowStatus(ownUserId, followerId);
    ResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, 'Successful');
    }else{
      responseModel = ResponseModel(false, 'Unsuccessful');
    }
    return responseModel;
  }

  Future<ResponseModel> blockChatUser(String userId, String blockUserId) async{
    Response response = await signalRepo.blockChatUser(userId, blockUserId);
    ResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, 'Successful');
    }else{
      responseModel = ResponseModel(false, 'Unsuccessful');
    }
    return responseModel;
  }

  List<RosterModel> _suggestionRosterList = [];
  List<RosterModel> get suggestionRosterList => _suggestionRosterList;

  List<RosterModel> _searchSuggestionList = [];
  List<RosterModel> get searchSuggestionList => _searchSuggestionList;

  bool _isSuggestionRosterEmpty = true;
  bool get isSuggestionRosterEmpty => _isSuggestionRosterEmpty;

  void getRosterSuggestion(String userId) async{
    Response response = await signalRepo.getSuggestionRoster(userId);
    if(response.statusCode == 200){
      _suggestionRosterList.clear();
      _searchSuggestionList.clear();
      jsonDecode(response.body).forEach((roster){
        _suggestionRosterList.add(RosterModel.fromJson(roster));
        _searchSuggestionList.add(RosterModel.fromJson(roster));
      });
      _isSuggestionRosterEmpty = false;
      update();
    }else{
      _logger.e(response.statusText);
    }
    update();
  }


  searchUserData(String text) async{
    _searchSuggestionList = [];
    if (text.isEmpty) {
      update();
    }
    for(var data in _suggestionRosterList){
      if(data.nickName!.toLowerCase().contains(text) || data.nickName!.toUpperCase().contains(text)){
        _searchSuggestionList.add(data);
      }
    }
    update();
  }


  bool _isSearchActive = false;
  bool get isSearchActive => _isSearchActive;

  void toggleSearchActive() {
    _isSearchActive = !_isSearchActive;
    update();
  }

  void setSearchActive(bool value, notify) {
    _isSearchActive = value;
    if(notify){
      update();
    }
  }

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  setSearch(bool val, bool notify){
    _isSearch = val;
    if(notify){
      update();
    }
  }



  void reset() async {
    try{
      var connectionState = hubConnection.state;
      if(connectionState != HubConnectionState.Connected) {
        loginSignal();
      }
    }catch(e){
      signalRService = SignalRService();
      hubConnection = signalRService.hubConnection;
    }
  }

  void logout() async{
    if(hubConnection.state != HubConnectionState.Connected){
      await loginSignal().then((value) {
        signalRService.dispose();
      });
    }
    signalRService.dispose();
  }

  Future<void> getCurrentLocation(MessageModel messageModel) async{
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      print('Latitude: $latitude, Longitude: $longitude');
      String message = 'https://www.google.com/maps?q=$latitude,$longitude';

      sendMessage(messageModel.withUserId!, messageModel.name!, message);
    } catch (e) {
      print('Error: $e');
    }
  }



}