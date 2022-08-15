import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
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


  bool isPanicSwitched = false;
  bool isObservationSwitched = false;
  bool isShutdownSwitched = false;
  bool isAirplaneSwitched = false;

  String username = "username";

  late double height;
  late double width;

  //Bluetooth
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  @override
  void initState() {
    // TODO: implement initState
    fetchData();


    initRenderers();
    _getUserMedia();

    super.initState();
  }

  @override
  void dispose(){
    _localRenderer.dispose();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: black20BoldTextStyle,
        ),
      ),
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
                username,
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
                        'Basic',
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
                          'Upgrade plan',
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
        title('Security Features'),
        SizedBox(
          height: height * .55,
          child: SettingsList(
            sections: [
              SettingsSection(
                  title: Text('Emergency'),
                  tiles: [
                    SettingsTile.switchTile(
                      title: Text('Panic Trigger'),
                      leading: Icon(Icons.health_and_safety),
                      initialValue: isPanicSwitched,
                      onToggle: (value) {
                        setState(() {
                          isPanicSwitched = value;
                          panicTrigger(value);
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Observation Trigger'),
                      leading: const Icon(Icons.video_call),
                      initialValue: isObservationSwitched,
                      onToggle: (value) {
                        setState(() {
                          isObservationSwitched = value;
                          onservationTrigger(value);
                        });
                      },
                    )
                  ]),
              SettingsSection(
                  title: Text('Upcoming'),
                  tiles: [
                    SettingsTile.switchTile(
                      title: Text('Fake ShutDown Mode'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isShutdownSwitched,
                      onToggle: (value) {
                        setState(() {
                          isShutdownSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Fake Airplane Mode'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isAirplaneSwitched,
                      onToggle: (value) {
                        setState(() {
                          isAirplaneSwitched = value;
                        });
                      },
                    ),
                  ]),
              SettingsSection(
                  title: Text('Contacts'),
                  tiles: [
                    SettingsTile(
                      title: Text('Notify Number'),
                      leading: Icon(Icons.phone),
                      onPressed: (BuildContext context) {
                        insert_numbers();
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
            'See all',
            style: primaryColor12BlackTextStyle,
          ),
        ],
      ),
    );
  }

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('username') ?? "Not Valid";
    setState(() {
      username = data;
    });
  }

  void panicTrigger(bool panicSwitch) async{
    if(panicSwitch){
      print("Panic Switch Triggered");

      beaconBroadcast
          .setUUID('39ED98FF-2900-441A-802F-9C398FC199D2')
          .setMajorId(1)
          .setMinorId(100)
          .setIdentifier("Safety")
          .setExtraData([1])
          .start();

      try {
        final int panic_value =  await platform.invokeMethod('startPanicService');
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }else{
      print("Panic Switch Off");

      beaconBroadcast.stop();

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

      _connect();

    }else{
      print("Observation Switch Off");
    }
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

  void insert_numbers() {
    print("Insert Number Field Selected");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotifyContact()),
    );
  }

  _accept() {
    if (_session != null) {
      _signaling?.accept(_session!.sid, true);
    }
  }

}
