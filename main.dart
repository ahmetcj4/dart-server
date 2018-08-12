import 'dart:async';
import 'dart:io';

final File file = new File('index.html');
Future main() async {
  HttpServer server = await HttpServer.bind(
    "127.0.0.1",
    8080,
  ); 
  print("Listenning on Localhost:${server.port}");

  await for (var req in server){
    if (await file.exists()){
      print('Serving ${file.path}');
      req.response.headers.contentType = ContentType.HTML;

      await file.openRead().pipe(req.response);
    }
  }
}
