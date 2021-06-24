import 'package:first_web_socket/client_page.dart';
import 'package:first_web_socket/server_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
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

class MyHomePage extends HookWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final myIP = useState("");
    final controller = useTextEditingController(text: "192.168.0.29");

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientPage(
                                    hostname: controller.text,
                                  )));
                    },
                    child: Text("ClientPage"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // var wifiBSSID = await (NetworkInfo().getWifiBSSID());
                String? wifiIP = await (NetworkInfo().getWifiIP());
                // var wifiName = await (NetworkInfo().getWifiName());
                // print(wifiBSSID);
                print(wifiIP);
                myIP.value = wifiIP ?? "";
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$wifiIP")));
                // print(wifiName);
              },
              child: Text(
                  "Wifi Info${myIP.value.toString().isEmpty ? "" : "(${myIP.value.toString()})"}"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
