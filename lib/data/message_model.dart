class MessageModel {
  int? messageId;
  String? replyId;
  String? name;
  String? photo;
  String? message;
  String? lastMessage;
  bool? isActive;
  bool? isSeen;
  bool? isMe;
  String? messageType;
  String? withUserId;
  String? toUserId;
  String? mediaUrl;
  int? unreadMessageCount;
  bool? isRequest;
  bool? isHide;
  bool? isDeleteAccount;
  bool? isBlockedByMe;
  bool? isBlockedByYou;
  String? createdAt;
  String? updatedAt;

  MessageModel(
      {this.messageId,
        this.replyId,
        this.name,
        this.photo,
        this.message,
        this.lastMessage,
        this.isActive,
        this.isSeen,
        this.isMe,
        this.messageType,
        this.withUserId,
        this.toUserId,
        this.mediaUrl,
        this.unreadMessageCount,
        this.isRequest,
        this.isHide,
        this.isDeleteAccount,
        this.isBlockedByMe,
        this.isBlockedByYou,
        this.createdAt,
        this.updatedAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    replyId = json['replyId'];
    name = json['name'];
    photo = json['photo'];
    message = json['message'];
    lastMessage = json['lastMessage'];
    isActive = json['isActive'] == 1;
    isSeen = json['isSeen'] == 1;
    isMe = json['isMe'] == 1;
    messageType = json['messageType'];
    withUserId = json['withUserId'];
    toUserId = json['toUserId'];
    mediaUrl = json['mediaUrl'];
    unreadMessageCount = json['unreadMessageCount'];
    isRequest = json['isRequest'] == 1;
    isHide = json['isHide'] == 1;
    isDeleteAccount = json['isDeleteAccount'] == 1;
    isBlockedByMe = json['isBlockedByMe'] == 1;
    isBlockedByYou = json['isBlockedByYou'] == 1;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageId'] = messageId;
    data['replyId'] = replyId;
    data['name'] = name;
    data['photo'] = photo;
    data['message'] = message;
    data['lastMessage'] = lastMessage;
    data['isActive'] = isActive;
    data['isSeen'] = isSeen;
    data['isMe'] = isMe;
    data['messageType'] = messageType;
    data['withUserId'] = withUserId;
    data['toUserId'] = toUserId;
    data['mediaUrl'] = mediaUrl;
    data['unreadMessageCount'] = unreadMessageCount;
    data['isRequest'] = isRequest;
    data['isHide'] = isHide;
    data['isDeleteAccount'] = isDeleteAccount;
    data['isBlockedByMe'] = isBlockedByMe;
    data['isBlockedByYou'] = isBlockedByYou;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class RequestModel {
  String? withUserId;
  String? createdAt;
  String? updatedAt;

  RequestModel(
      {
        this.withUserId,
        this.createdAt,
        this.updatedAt});

  RequestModel.fromJson(Map<String, dynamic> json) {
    withUserId = json['withUserId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['withUserId'] = withUserId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


class RosterModel {
  String? id;
  String? userId;
  String? nickName;
  String? photo;
  bool? isActive;
  String? lastOnline;
  List<String>? follower;

  RosterModel({
    required this.id,
    required this.userId,
    required this.nickName,
    required this.photo,
    required this.isActive,
    required this.lastOnline,
    required this.follower,
  });

  RosterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    nickName = json['nickName'];
    photo = json['photo'];
    isActive =  json['isActive'];
    lastOnline = json['lastOnline'];
    follower =  List<String>.from(json['follower']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'nickName': nickName,
      'photo': photo,
      'isActive': isActive,
      'lastOnline': lastOnline,
      'follower': follower,
    };
  }
}
