import 'package:women_safety_flutter/pages/screens.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:settings_ui/settings_ui.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitched = false;
  String username = "username";

  late double height;
  late double width;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
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
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                width: 160.0,
                lineHeight: 3.0,
                percent: 0.77,
                progressColor: primaryColor,
                backgroundColor: greyColor,
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
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
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
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Fake Airplane Mode'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    // SettingsTile.switchTile(
                    //   title: Text('Lock Application'),
                    //   leading: Icon(Icons.phone_android),
                    //   initialValue: isSwitched,
                    //   onToggle: (value){
                    //     setState(() {
                    //       isSwitched = value;
                    //     });
                    //   },
                    // ),
                    // SettingsTile.switchTile(
                    //   title: Text('Low Battery SMS'),
                    //   leading: Icon(Icons.phone_android),
                    //   initialValue: isSwitched,
                    //   onToggle: (value){
                    //     setState(() {
                    //       isSwitched = value;
                    //     });
                    //   },
                    // ),
                    // SettingsTile.switchTile(
                    //   title: Text('Protective Selfie'),
                    //   leading: Icon(Icons.phone_android),
                    //   initialValue: isSwitched,
                    //   onToggle: (value){
                    //     setState(() {
                    //       isSwitched = value;
                    //     });
                    //   },
                    // ),
                    // SettingsTile.switchTile(
                    //   title: Text('Car Collition Detector'),
                    //   leading: Icon(Icons.phone_android),
                    //   initialValue: isSwitched,
                    //   onToggle: (value){
                    //     setState(() {
                    //       isSwitched = value;
                    //     });
                    //   },
                    // ),
                  ]),
              SettingsSection(
                  title: Text('Contacts'),
                  tiles: [
                    SettingsTile(
                      title: Text('Notify Number'),
                      leading: Icon(Icons.phone),
                      onPressed: (BuildContext context) {},
                    ),
                  ]),
            ],
          ),
        ),
      ],
    );
  }

  numberSettings() {
    return Column(
      children: [
        title('Security Features'),
        SizedBox(
          height: height * 0.45,
          child: SettingsList(
            sections: [
              SettingsSection(
                  title: Text('Emergency'),
                  tiles: [
                    SettingsTile.switchTile(
                      title: Text('Panic Trigger'),
                      leading: Icon(Icons.health_and_safety),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
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
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Fake Airplane Mode'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Lock Application'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Low Battery SMS'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Protective Selfie'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Car Collition Detector'),
                      leading: Icon(Icons.phone_android),
                      initialValue: isSwitched,
                      onToggle: (value) {
                        setState(() {
                          isSwitched = value;
                        });
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
}
