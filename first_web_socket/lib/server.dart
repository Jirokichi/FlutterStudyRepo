import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'models.dart';

class Server {
  Server({required this.onError, required this.onData});

  Uint8ListCallback onData;
  DynamicCallback onError;
  ServerSocket? server;
  bool running = false;
  List<Socket> sockets = [];

  start({String ipAddress = "0.0.0.0"}) async {
    runZoned(() async {
      server = await ServerSocket.bind(ipAddress, 4040);
      this.running = true;
      server?.listen(_onRequest);
      this.onData(Uint8List.fromList(
          'Server($ipAddress) listening on port 4040'.codeUnits));
    }, onError: (e) {
      this.onError(e);
    });
  }

  stop() async {
    await this.server?.close();
    this.server = null;
    this.running = false;
  }

  broadCast(String message) {
    this.onData(Uint8List.fromList('Broadcasting : $message'.codeUnits));
    for (Socket socket in sockets) {
      socket.write(message + '\n');
    }
  }

  _onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((Uint8List data) {
      this.onData(data);
    });
  }
}
