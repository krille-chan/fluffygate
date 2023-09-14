import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:shelf/shelf.dart';

import 'config.dart';
import 'push_notification.dart';

Future<Response> pushHandler(
  Request request,
  AuthClient client,
  Config config,
) async {
  // The list of rejected pushkeys will be returned later.
  final rejected = <String>[];

  // Read and validate the Push Notification object:
  final body = await request.readAsString();
  late final Map<String, Object?> json;
  late final PushNotification pushNotification;
  try {
    json = jsonDecode(body);
  } catch (e) {
    return Response.badRequest(
      body: jsonEncode(
        {"errcode": "M_NOT_JSON", "error": e.toString()},
      ),
    );
  }
  try {
    pushNotification = PushNotification.fromJson(json);
  } catch (e) {
    return Response.badRequest(
      body: jsonEncode(
        {"errcode": "M_BAD_JSON", "error": e.toString()},
      ),
    );
  }

  final uri = Uri.https(
    'fcm.googleapis.com',
    '/v1/projects/${config.projectId}/messages:send',
  );

  final unread = pushNotification.notification.counts?.unread ?? 0;
  final data = pushNotification.notification.toStringMap();

  // Send a request to FCM for each device
  for (final device in pushNotification.notification.devices) {
    final body = {
      'message': {
        'token': device.pushkey,
        'data': data,
        if (!device.isDataMessage && unread > 0)
          'notification': {
            'title': config.notificationTitle,
            'body': config.notificationBody,
          },
        'android': {...config.androidNotificationOptions},
        'apns': {...config.apnsNotificationOptions},
      },
    };

    if (device.isDataMessage) {
      (body['message']?['android'] as Map?)?.remove('notification');
    }

    final jsonBody = jsonEncode(body)
        .replaceAll('"{count}"', unread.toString())
        .replaceAll('{count}', unread.toString());
    if (config.debugLogs) print('Send to FCM:--->\n$jsonBody');
    final response = await client.post(
      uri,
      body: jsonBody,
    );
    if (config.debugLogs) print('<--- Response from FCM:\n${response.body}');

    if (response.statusCode != 200) rejected.add(device.pushkey);
  }

  return Response.ok(jsonEncode({"rejected": rejected}));
}
