import 'package:first_web_socket/client_page.dart';
import 'package:first_web_socket/server_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Web Socket Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServerPage()));
              },
              child: Text("ServerPage"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClientPage()));
              },
              child: Text("ClientPage"),
            ),
            ElevatedButton(
              onPressed: () async {
                // var wifiBSSID = await (NetworkInfo().getWifiBSSID());
                String? wifiIP = await (NetworkInfo().getWifiIP());
                // var wifiName = await (NetworkInfo().getWifiName());
                // print(wifiBSSID);
                print(wifiIP);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$wifiIP")));
                // print(wifiName);
              },
              child: Text("Wifi Info"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
