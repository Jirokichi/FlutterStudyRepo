import 'dart:io';
import 'dart:typed_data';

import 'models.dart';

class Client {
  Client({
    required this.onError,
    required this.onData,
    required this.hostname,
    required this.port,
  });

  String hostname;
  int port;
  Uint8ListCallback onData;
  DynamicCallback onError;
  bool connected = false;

  Socket? socket;

  connect() async {
    try {
      print("hostname: $hostname");
      socket = await Socket.connect(hostname, 4040);
      print("socket: $socket");
      socket?.listen(
        onData,
        onError: onError,
        onDone: disconnect,
        cancelOnError: false,
      );
      connected = true;
    } on Exception catch (exception) {
      print("$exception");
      onData(Uint8List.fromList("Error : $exception".codeUnits));
    }
  }

  write(String message) {
    //Connect standard in to the socket
    socket?.write(message + '\n');
  }

  disconnect() {
    if (socket != null) {
      socket?.destroy();
      connected = false;
    }
  }
}
