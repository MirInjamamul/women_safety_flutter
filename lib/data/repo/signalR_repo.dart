import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:women_safety_flutter/api_client.dart';

class SignalRepo extends GetxController implements GetxService{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  SignalRepo({required this.sharedPreferences, required this.apiClient});

  // void setNick(HubConnection hubConnection, String nick) => hubConnection.invoke("join", args: [nick]);
  void setNick(HubConnection hubConnection, String userId) => hubConnection.invoke("Connect", args: [userId]);

  void sendMessage(HubConnection hubConnection, String receiverId, String message) => hubConnection.invoke("SendPrivateMessage", args: [receiverId, message]);

  void sendLiveMatchInvitation(HubConnection hubConnection,String receiverUserId,String senderId, String name, String photo, String roomId) {
    hubConnection.invoke("LiveInviteToUser", args: [receiverUserId, senderId, roomId, name, photo, 'invited for Live Match']);
  }

  // void showInvitationDialogue(String roomId,String name, String photo) {
  //   Get.bottomSheet(InvitePKBottomSheet(roomId: int.parse(roomId),hostId: /*int.parse(hostId)*/ 0, name: name, photo: photo,));
  // }

  Future<Response> getOnlineRosterUsers(String userId)async{
    return await apiClient.getOnlineRosterUsers(userId);
  }

  Future<Response> getLastOnline(List<String> userIds)async{
    return await apiClient.getLastOnlineDetails(userIds);
  }

  Future<Response> getBlockUserCheck(String userId, String blockId)async{
    return await apiClient.getBlockUserCheck(userId, blockId);
  }

  Future<Response> changeFollowStatus(String ownUserId, String followerId)async{
    return await apiClient.changeFollowStatus(ownUserId, followerId);
  }

  Future<Response> getSuggestionRoster(String userId)async{
    return await apiClient.getSuggestionList(userId);
  }

  Future<Response> blockChatUser(String userId, String blockedId)async{
    return await apiClient.blockChatUser(userId, blockedId);
  }

}