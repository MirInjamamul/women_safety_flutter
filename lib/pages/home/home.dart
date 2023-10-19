import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/auth_controller.dart';
import 'package:women_safety_flutter/controllers/home_controller.dart';
import 'package:women_safety_flutter/custom_appbar.dart';
import 'package:women_safety_flutter/pages/profile/contact_list.dart';
import 'package:women_safety_flutter/pages/screens.dart';
import 'package:settings_ui/settings_ui.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// RTC Variable

  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  Signaling? _signaling;
  Session? _session;
  bool _inCalling = false;
  bool _waitAccept = false;
  String? _selfId;
  List<dynamic> _peers = [];

  bool isShutdownSwitched = false;
  bool isAirplaneSwitched = false;


  late double height;
  late double width;

  @override
  void initState() {
    // TODO: implement initState

    // initRenderers();
    // _getUserMedia();


    super.initState();
  }

  @override
  void dispose(){
    _localRenderer.dispose();
    _localStream = null;
    _localRenderer.srcObject = null;
    super.dispose();
  }

  initRenderers() async {
    await _localRenderer.initialize();
  }

  _getUserMedia() async {
    final Map<String, dynamic> cons = {
      'audio': true,
      'video': {
        'mandatory': {
          'maxWidth': '640',
          'maxHeight': '480',
          'minFrameRate': '15',
          'maxFrameRate': '25'
        },
        'facingModel': 'user',
      },
    };

    MediaDevices.getUserMedia(cons).then((stream) {
      _localStream = stream;
      _localRenderer.srcObject = _localStream;

    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;

    width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: const Color(0xFFE7ECEF),
      appBar:  CustomAppBar(title: 'settings'.tr,),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
        children: [
          userProfile(),
          featureSettings(),
        ],
      ),
    );
  }

  userProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage('assets/users/user1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          widthSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Get.find<AuthController>().getName(),
                style: black16BoldTextStyle,
              ),
              Text(
                'LV-651232',
                style: grey14RegularTextStyle,
              ),
              heightSpace,
              Text(
                '77% Profile Completion',
                style: grey13RegularTextStyle,
              ),
              heightSpace,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding,
                        vertical: 3,
                      ),
                      color: primaryColor,
                      child: Text(
                        'basic'.tr,
                        style: white13RegularTextStyle,
                      ),
                    ),
                    InkWell(
                      //TODO
                      // onTap: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const UpgradePlan()),
                      // ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding,
                          vertical: 3,
                        ),
                        child: Text(
                          'upgrade_plan'.tr,
                          style: primaryColor13RegularTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  featureSettings() {
    return Column(
      children: [
        title('security_features'.tr),
        SizedBox(
          height: height * .55,
          child: SettingsList(
            sections: [
              SettingsSection(
                  title: Text('emergency'.tr),
                  tiles: [
                    SettingsTile.switchTile(
                      title: Text('panic_trigger'.tr),
                      leading: Icon(Icons.health_and_safety),
                      initialValue: Get.find<HomeController>().isPanicSwitced,
                      onToggle: (value) {
                        setState(() {
                          Get.find<HomeController>().setPanicTrigger(value);
                          panicTrigger(value);
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title:  Text('observation_trigger'.tr),
                      leading: const Icon(Icons.video_call),
                      initialValue: Get.find<HomeController>().isObservationSwitched,
                      onToggle: (value) {
                        setState(() {
                          Get.find<HomeController>().setObservationTrigger(value);
                          onservationTrigger(value);
                        });
                      },
                    ),
                    /*SettingsTile.switchTile(
                      title: Text('বিরতিহীন শাটডাউন মোড'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isShutdownSwitched,
                      onToggle: (value) {
                        setState(() {
                          isShutdownSwitched = value;
                          fakeShutDownTrigger(value);
                        });
                      },
                    ),*/
                  ]),
            /*  SettingsSection(
                  title: Text('নতুন '),
                  tiles: [
                    SettingsTile.switchTile(
                      title: const Text('ফ্যাক  এরোপ্লেন মোড'),
                      leading: const Icon(Icons.phone_android),
                      initialValue: isAirplaneSwitched,
                      onToggle: (value) {
                        setState(() {
                          isAirplaneSwitched = value;
                        });
                      },
                    ),
                  ]),*/
              SettingsSection(
                  title: Text('contact'.tr),
                  tiles: [
                    SettingsTile(
                      title: Text('save_contact'.tr),
                      leading: Icon(Icons.phone),
                      onPressed: (BuildContext context) {
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => NotifyContact()));
                        Navigator.push(context, CupertinoPageRoute(builder: (_) => const ContactsScreen()));
                      },
                    ),
                  ]),

            ],
          ),
        ),
      ],
    );
  }

  title(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: black16BoldTextStyle,
          ),
          Text(
            'all_of_them'.tr,
            style: primaryColor12BlackTextStyle,
          ),
        ],
      ),
    );
  }


  void panicTrigger(bool panicSwitch) async{
    if(panicSwitch){
      print("Panic Switch Triggered");

      try {
        final int panic_value =  await platform.invokeMethod('startPanicService');
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }else{
      print("Panic Switch Off");

      try {
        final int panic_value =  await platform.invokeMethod('stopPanicService');
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }
  }

  void onservationTrigger(bool observationSwitch) async{
    if(observationSwitch){
      print("Observation Switch Triggered");

      initRenderers();
      _getUserMedia().then((value){
        _connect();
      });



    }else{
      print("Observation Switch Off");
      _disconnect();
    }
  }

  void fakeShutDownTrigger(bool fakeShutDownSwitch)async{
    if(fakeShutDownSwitch){
      _disablePowerButton();
    }else{
      _enablePowerButton();
    }
  }

  void _disablePowerButton() {
    debugPrint('FakeShutdown Activated');
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void _enablePowerButton() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }


  _connect() async {
    String user = "safety";
    _signaling ??= Signaling('bamboojs.com', user)..connect('Safety');
    _signaling?.onSignalingStateChange = (SignalingState state) {
      switch (state) {
        case SignalingState.ConnectionClosed:
        case SignalingState.ConnectionError:
        case SignalingState.ConnectionOpen:
          break;
      }
    };

    _signaling?.onCallStateChange = (Session session, CallState state) async {
      switch (state) {
        case CallState.CallStateNew:
          setState(() {
            _session = session;
          });
          break;
        case CallState.CallStateRinging:

          _accept();
          setState(() {
            _inCalling = true;
          });

          break;
        case CallState.CallStateBye:
          if (_waitAccept) {
            print('peer reject');
            _waitAccept = false;
            Navigator.of(context).pop(false);
          }
          setState(() {
            _localRenderer.srcObject = null;
            _inCalling = false;
            _session = null;
          });
          break;
        case CallState.CallStateInvite:
          _waitAccept = true;
          break;
        case CallState.CallStateConnected:
          if (_waitAccept) {
            _waitAccept = false;
            Navigator.of(context).pop(false);
          }
          setState(() {
            print("User ---> Call_State Connected");
            _inCalling = true;
          });
          break;
        case CallState.CallStateSreamConnected:
          setState(() {
            print("User ---> Call_State Stream Connected");
            _inCalling = true;
          });

          break;
        case CallState.CallStateAudioRinging:
        // TODO: Handle this case.
          break;
        case CallState.CallStateAudioInvite:
        // TODO: Handle this case.
          break;
        case CallState.CallStateAudioConnected:
          // TODO: Handle this case.
          break;
      }
    };

    _signaling?.onPeersUpdate = ((event) {
      setState(() {
        _selfId = event['self'];
        _peers = event['peers'];
      });
    });

    _signaling?.onLocalStream = ((stream) {
      _localRenderer.srcObject = stream;
    });

    _signaling?.onAddRemoteStream = ((_, stream) {
      // _remoteRenderer.srcObject = stream;
    });

    _signaling?.onRemoveRemoteStream = ((_, stream) {
    });
  }

  _disconnect(){
    // _signaling?.close();
    // _localRenderer.dispose();

  }


  _accept() {
    if (_session != null) {
      _signaling?.accept(_session!.sid, true);
    }
  }

}
