import 'dart:async';
import 'dart:io';

Future main() async {
  HttpServer server = await HttpServer.bind(
    "127.0.0.1",
    8080,
  ); 
  print("Listenning on Localhost:${server.port}");

  server.listen((HttpRequest req){
    req.response
    ..write("This is response")
    ..close();
  });
}
