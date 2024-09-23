import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'config.dart';
import 'not_found_handler.dart';
import 'push_handler.dart';
import 'status_handler.dart';

void init(String configFilePath) async {
  final config = Config.fromConfigFilePath(configFilePath);
  final fcmKeyJson = jsonDecode(
    File(config.fcmKeyFilePath).readAsStringSync(),
  );

  final client = await clientViaServiceAccount(
    ServiceAccountCredentials.fromJson(fcmKeyJson),
    ['https://www.googleapis.com/auth/firebase.messaging'],
  );

  final router = Router(notFoundHandler: notFoundHandler)
    ..get('/', (Request request) => statusHandler(request, config))
    ..post(
      '/_matrix/push/v1/notify',
      (Request request) => pushHandler(
        request,
        client,
        config,
      ),
    );

  final server = await serve(
    Pipeline().addMiddleware(logRequests()).addHandler(router.call),
    config.bindAddress ?? InternetAddress.anyIPv4,
    config.port,
  );

  print('Server is listening to port ${server.port}');
}
