import 'dart:convert';

import 'package:test/test.dart';

import '../src/push_notification.dart';

void main() {
  const jsonString = '''
{
  "notification": {
    "content": {
      "body": "I'm floating in a most peculiar way.",
      "msgtype": "m.text"
    },
    "counts": {
      "missed_calls": 1,
      "unread": 2
    },
    "devices": [
      {
        "app_id": "org.matrix.matrixConsole.ios",
        "data": {},
        "pushkey": "V2h5IG9uIGVhcnRoIGRpZCB5b3UgZGVjb2RlIHRoaXM/",
        "pushkey_ts": 12345678,
        "tweaks": {
          "sound": "bing"
        }
      }
    ],
    "event_id": "\$3957tyerfgewrf384",
    "prio": "high",
    "room_alias": "#exampleroom:matrix.org",
    "room_id": "!slw48wfj34rtnrf:example.com",
    "room_name": "Mission Control",
    "sender": "@exampleuser:matrix.org",
    "sender_display_name": "Major Tom",
    "type": "m.room.message"
  }
}
''';
  test('Push Notification deserialize', () {
    final pushNotification = PushNotification.fromJson(jsonDecode(jsonString));

    expect(pushNotification.notification.prio, Prio.high);
    expect(
        pushNotification.notification.devices.single.tweaks!['sound'], 'bing');
  });
}
