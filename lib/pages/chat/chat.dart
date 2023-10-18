import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/signalR_controller.dart';
import 'package:women_safety_flutter/utils/api_config.dart';
import 'package:women_safety_flutter/utils/images.dart';

import '../../constants/constants.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver{
  final messageController = TextEditingController();
  String? _currentMessage;
  DateTime time = DateTime.now();
  ScrollController scrollController = ScrollController();

  void animateList() {
    if(scrollController.hasClients){
      scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }
  @override
  void initState() {
    Get.find<SignalRController>().getSingleMsgFromDB(ApiConfig.adminId, true);

    scrollController.addListener(() {
      if(!Get.find<SignalRController>().isLoading){
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          Get.find<SignalRController>().showLoader();
          Get.find<SignalRController>().getSingleMsgFromDB(ApiConfig.adminId, false);
        }
      }
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignalRController>(
      builder: (signalR) => Scaffold(
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
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: scrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  itemCount: signalR.messageList.length,
                  itemBuilder: (context, index) {
                    final item = signalR.messageList[index];
                    return item.isMe! ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 230),
                          margin: const EdgeInsets.only(
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
                                signalR.messageList[index].message ?? '',
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
                                  image: AssetImage(Images.meUser),
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
                                  image: AssetImage(Images.user),
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
                          margin: const EdgeInsets.only(
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
                                signalR.messageList[index].message ?? '',
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
              ),
            ),
            Container(
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
                          signalR.sendMessage('1002', 'admin', messageController.text, isReply: false, messageId: signalR.messageList.length+1).then((value){
                            messageController.clear();
                            animateList();
                          });
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          size: 20,
                          color: greyColor,
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      widthSpace,
                      widthSpace,
                    ],
                  ),
                  border: const UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
