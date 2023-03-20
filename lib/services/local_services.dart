
import 'package:flutter/material.dart';
import 'package:xmpp_plugin/ennums/xmpp_connection_state.dart';
import 'package:xmpp_plugin/xmpp_plugin.dart';

class LocalService {

  static XmppConnection? xmppClient;

  Future<XmppConnection?> getXmppConnection() async {
    var jid = 'user1@bamboojs.com';
    var password = '123456';

    if (xmppClient != null) {
      debugPrint("calling xmpp");
      XmppConnectionState? connectionStatus = await xmppClient
          ?.getConnectionStatus();

      debugPrint("XMPP-STATE ${connectionStatus.toString()}");

      if (connectionStatus == XmppConnectionState.failed) {
        //TODO add this pass dynamically
        debugPrint("XMPP-STATE -> Failed");
        var auth = {
          "user_jid": jid,
          "password": password,
          "host": "bamboojs.com",
          "port": 5222
        };

        xmppClient = XmppConnection(auth);
        await xmppClient?.login().then((value) async {
          // start listening receive message
          await xmppClient?.start(_onError);
          return xmppClient;
        });
        debugPrint("XMPP-STATE -> login ");
      } else if (connectionStatus == XmppConnectionState.disconnected) {
        debugPrint("XMPP-STATE -> Disconnected");

        var auth = {
          "user_jid": jid,
          "password": password,
          "host": "bamboojs.com",
          "port": 5222
        };

        xmppClient = XmppConnection(auth);
        await xmppClient?.login().then((value) async {
          // start listening receive message
          await xmppClient?.start(_onError);
          return xmppClient;
        });

        debugPrint("XMPP-STATE -> login ");
      } else if (connectionStatus == XmppConnectionState.authenticated) {
        debugPrint("XMPP-STATE -> Already Login  ");
      }
      return xmppClient;
    }
    else {
      debugPrint("XMPP-STATE -> null ");

      var auth = {
        "user_jid": jid,
        "password": password,
        "host": "bamboojs.com",
        "port": 5222
      };
      xmppClient = XmppConnection(auth);

      await xmppClient?.login().then((value) async {
        // start listening receive message
      await xmppClient?.start(_onError);

        return xmppClient;
      });
      debugPrint("XMPP-STATE -> login ");
    }

    return xmppClient;
  }

  void _onError(Object error){
    debugPrint(error.toString());
  }

  logoutXMPP() async{
    xmppClient = (await getXmppConnection())!;
    xmppClient!.logout();
  }
}