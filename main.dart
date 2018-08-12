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
    HttpResponse response = req.response
      ..headers.contentType = ContentType.HTML;
    if (req.method == 'GET') {
      String filename = req.uri.pathSegments.last;

      if (!filename.endsWith('.html')) {
        filename = filename + '.html';
      }

      File file = new File(filename);
      if (!await file.exists()) {
        file
            .openWrite(mode: FileMode.write)
            .write('<h1>This is $filename page</h1>');
      }
      file.openRead().pipe(response);
    }
  }
}
