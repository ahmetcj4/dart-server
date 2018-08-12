import 'dart:async';
import 'dart:io';

final File file = new File('index.html');
Future main() async {
  HttpServer server;
  try {
    server = await HttpServer.bind(
      "127.0.0.1",
      8080,
    );
  } catch (e) {
    print('Failed to start server $e');
    exit(-1);
  }

  print("Listenning on Localhost:${server.port}");

  await for (var req in server) {
    if (await file.exists()) {
      print('Serving ${file.path}');
      req.response.headers.contentType = ContentType.HTML;

      try {
        await file.openRead().pipe(req.response);
      } catch (e) {
        print('Couldn\'t read file $e');
        exit(-1);
      }
    } else {
      print('Can\'t open file');
      req.response
        ..statusCode = HttpStatus.NOT_FOUND
        ..close();
    }
  }
}
