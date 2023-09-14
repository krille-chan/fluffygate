import 'dart:convert';

class PushNotification {
  final Notification notification;

  const PushNotification({
    required this.notification,
  });

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      PushNotification(
        notification: Notification.fromJson(json['notification']),
      );

  Map<String, dynamic> toJson() => {
        'notification': notification.toJson(),
      };
}

enum Prio { high, low }

class Notification {
  final Map<String, Object?>? content;
  final Counts? counts;
  final List<Device> devices;
  final String? eventId;
  final Prio? prio;
  final String? roomAlias;
  final String? roomId;
  final String? roomName;
  final String? sender;
  final String? senderDisplayName;
  final String? type;

  const Notification({
    this.content,
    this.counts,
    required this.devices,
    this.eventId,
    this.prio,
    this.roomAlias,
    this.roomId,
    this.roomName,
    this.sender,
    this.senderDisplayName,
    this.type,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        content: json['content'],
        counts: json['counts'] == null ? null : Counts.fromJson(json['counts']),
        devices:
            (json['devices'] as List).map((i) => Device.fromJson(i)).toList(),
        eventId: json['event_id'],
        prio: json['prio'] == null
            ? null
            : Prio.values.singleWhere((prio) => prio.name == json['prio']),
        roomAlias: json['room_alias'],
        roomId: json['room_id'],
        roomName: json['room_name'],
        sender: json['sender'],
        senderDisplayName: json['sender_display_name'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        if (content != null) 'content': content,
        if (counts != null) 'counts': counts!.toJson(),
        'devices': devices.map((i) => i.toJson()).toList(),
        if (eventId != null) 'event_id': eventId,
        if (prio != null) 'prio': prio!.name,
        if (roomAlias != null) 'room_alias': roomAlias,
        if (roomId != null) 'room_id': roomId,
        if (roomName != null) 'room_name': roomName,
        if (sender != null) 'sender': sender,
        if (senderDisplayName != null) 'sender_display_name': senderDisplayName,
        if (type != null) 'type': type,
      };

  Map<String, String> toStringMap() => {
        if (content != null) 'content': jsonEncode(content),
        if (counts != null) 'counts': jsonEncode(counts!.toJson()),
        'devices': jsonEncode(devices.map((i) => i.toJson()).toList()),
        if (eventId != null) 'event_id': eventId!,
        if (prio != null) 'prio': prio!.name,
        if (roomAlias != null) 'room_alias': roomAlias!,
        if (roomId != null) 'room_id': roomId!,
        if (roomName != null) 'room_name': roomName!,
        if (sender != null) 'sender': sender!,
        if (senderDisplayName != null)
          'sender_display_name': senderDisplayName!,
        if (type != null) 'type': type!,
      };
}

class Counts {
  final int? missedCalls;
  final int? unread;

  const Counts({
    this.missedCalls,
    this.unread,
  });

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
        missedCalls: json['missed_calls'],
        unread: json['unread'],
      );

  Map<String, dynamic> toJson() => {
        if (missedCalls != null) 'missed_calls': missedCalls,
        if (unread != null) 'unread': unread,
      };
}

class Device {
  final String appId;
  final Map<String, Object?>? data;
  final String pushkey;
  final int? pushkeyTs;
  final Map<String, Object?>? tweaks;

  const Device({
    required this.appId,
    this.data,
    required this.pushkey,
    this.pushkeyTs,
    this.tweaks,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        appId: json['app_id'],
        data: json['data'],
        pushkey: json['pushkey'],
        pushkeyTs: json['pushkey_ts'],
        tweaks: json['tweaks'],
      );

  Map<String, dynamic> toJson() => {
        'app_id': appId,
        if (data != null) 'data': data,
        'pushkey': pushkey,
        if (pushkeyTs != null) 'pushkey_ts': pushkeyTs,
        if (tweaks != null) 'tweaks': tweaks,
      };

  bool get isDataMessage =>
      appId.endsWith('.data_message') || data?['data_message'] == true;
}
