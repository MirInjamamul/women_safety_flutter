import 'package:women_safety_flutter/pages/screens.dart';
import 'package:xmpp_plugin/error_response_event.dart';
import 'package:xmpp_plugin/models/chat_state_model.dart';
import 'package:xmpp_plugin/models/connection_event.dart';
import 'package:xmpp_plugin/models/message_model.dart';
import 'package:xmpp_plugin/models/present_mode.dart';
import 'package:xmpp_plugin/success_response_event.dart';
import 'package:xmpp_plugin/xmpp_plugin.dart';

import '../../services/local_services.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat>  with WidgetsBindingObserver implements DataChangeEvents{
  final messageController = TextEditingController();
  String? _currentMessage;
  DateTime time = DateTime.now();

  //XMPP
  static late XmppConnection flutterXmpp;
  List<MessageChat> events = [];
  List<PresentModel> presentModel = [];
  String connectionStatus = "DisConnected";
  String connectionStatusMessage = "";


  List messageList = [
    // {
    //   'image': 'assets/users/user11.png',
    //   'message': 'Lorem Ipsum is simply dummy text',
    //   'time': '11:30',
    //   'isMe': false,
    // },
    // {
    //   'image': 'assets/users/user1.png',
    //   'message': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    //   'time': '11:31',
    //   'isMe': true,
    // },
    // {
    //   'image': 'assets/users/user11.png',
    //   'message': 'Ok, Ipsum is simply dummy',
    //   'time': '11:33',
    //   'isMe': false,
    // },
    // {
    //   'image': 'assets/users/user11.png',
    //   'message': 'Ok, Ipsum is simply',
    //   'time': '11:33',
    //   'isMe': false,
    // },
    // {
    //   'image': 'assets/users/user1.png',
    //   'message':
    //       'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    //   'time': '11:35',
    //   'isMe': true,
    // },
    // {
    //   'image': 'assets/users/user11.png',
    //   'message': 'Lorem Ipsum is simply dummy text',
    //   'time': '11:36',
    //   'isMe': false,
    // },
    // {
    //   'image': 'assets/users/user11.png',
    //   'message': '•••••',
    //   'time': '11:36',
    //   'isMe': false,
    // },
  ];

  @override
  void initState() {
    // TODO: implement initState

    XmppConnection.addListener(this);
    setConnection();

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    XmppConnection.removeListener(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HotLine',
              style: black20BoldTextStyle,
            ),
            Text(
              'Online',
              style: grey12RegularTextStyle,
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Call()),
                // );
              },
              child: const Icon(Icons.call)),
          widthSpace,
          const Icon(Icons.more_vert),
          widthSpace,
          widthSpace,
        ],
      ),
      body: Column(
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          messages(),
          textField(),
        ],
      ),
    );
  }

  messages() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final item = messageList[index];
          // bool m = (index == 0 || item['time'] != messageList[index - 1]['time'])
          //         ? true
          //         : false;
          return item['isMe']! == true
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 230),
                      margin: EdgeInsets.only(
                        bottom: fixPadding * 2.0,
                        right: 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 1.3,
                        vertical: fixPadding,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            item['message'] as String,
                            overflow: TextOverflow.fade,
                            style: white12RegularTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: fixPadding),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(item['image'] as String),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 8,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin:
                          const EdgeInsets.only(right: fixPadding),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(item['image'] as String),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 8,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 230),
                      margin: EdgeInsets.only(
                        bottom: fixPadding * 2.0,
                        left: 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 1.3,
                        vertical: fixPadding,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: greyColor.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            item['message'] as String,
                            overflow: TextOverflow.fade,
                            style: grey12RegularTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  textField() {
    final message = {
      'image': 'assets/users/user1.png',
      'message': _currentMessage,
      'time': time.toString(),
      'isMe': true,
    };
    return Container(
      height: 45,
      padding: const EdgeInsets.all(fixPadding),
      color: whiteColor,
      alignment: Alignment.center,
      child: TextField(
        onChanged: (value) {
          setState(() {
            _currentMessage = value;
          });
        },
        controller: messageController,
        cursorColor: primaryColor,
        style: black14SemiBoldTextStyle,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 2),
          hintText: 'Type your message',
          hintStyle: grey12RegularTextStyle,
          prefixIcon: const Icon(
            Icons.emoji_emotions_outlined,
            color: greyColor,
            size: 20,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.attach_file,
                size: 20,
                color: greyColor,
              ),
              widthSpace,
              widthSpace,
              const Icon(
                Icons.photo_camera,
                size: 20,
                color: greyColor,
              ),
              widthSpace,
              widthSpace,
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.15),
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic,
                  size: 20,
                  color: greyColor,
                ),
              ),
              widthSpace,
              widthSpace,
              InkWell(
                onTap: () {
                  messageController.clear();
                  setState(() {
                    messageList.add(message);
                  });

                  sendMessage(message['message'].toString());
                },
                child: const Icon(
                  Icons.send_rounded,
                  size: 20,
                  color: greyColor,
                ),
              ),
              widthSpace,
              widthSpace,
            ],
          ),
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  @override
  void onChatMessage(MessageChat messageChat) {
    // TODO: implement onChatMessage
    String messageText = messageChat.body ?? '';
    final message = {
      'image': 'assets/users/user1.png',
      'message': messageText,
      'time': time.toString(),
      'isMe': false,
    };
    setState(() {
      messageList.add(message);
    });
  }

  @override
  void onChatStateChange(ChatState chatState) {
    // TODO: implement onChatStateChange
  }

  @override
  void onConnectionEvents(ConnectionEvent connectionEvent) {
    // TODO: implement onConnectionEvents
  }

  @override
  void onGroupMessage(MessageChat messageChat) {
    // TODO: implement onGroupMessage
  }

  @override
  void onNormalMessage(MessageChat messageChat) {
    // TODO: implement onNormalMessage
  }

  @override
  void onPresenceChange(PresentModel message) {
    // TODO: implement onPresenceChange
  }

  @override
  void onSuccessEvent(SuccessResponseEvent successResponseEvent) {
    // TODO: implement onSuccessEvent
  }

  @override
  void onXmppError(ErrorResponseEvent errorResponseEvent) {
    // TODO: implement onXmppError
  }

  void sendMessage(String message){
    flutterXmpp.sendMessageWithType('police@bamboojs.com', message, 'id', DateTime.now().millisecondsSinceEpoch);
  }

  void setConnection() async{
    flutterXmpp = (await LocalService().getXmppConnection())!;
  }
}
