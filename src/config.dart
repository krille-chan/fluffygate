import 'dart:io';

import 'package:yaml/yaml.dart';

class Config {
  final int port;
  final String? bindAddress;

  final String fcmKeyFilePath;
  final String projectId;

  final String notificationTitle;
  final String notificationBody;

  final Map<String, Object?> androidNotificationOptions;
  final Map<String, Object?> apnsNotificationOptions;

  final bool debugLogs;

  const Config({
    required this.port,
    required this.bindAddress,
    required this.fcmKeyFilePath,
    required this.projectId,
    required this.notificationTitle,
    required this.notificationBody,
    required this.androidNotificationOptions,
    required this.apnsNotificationOptions,
    required this.debugLogs,
  });

  factory Config.fromConfigFilePath(String configFilePath) {
    final file = File(configFilePath);
    final yaml = loadYaml(file.readAsStringSync()) as Map;
    return Config(
      port: yaml['port'],
      bindAddress: yaml['bindAddress'],
      fcmKeyFilePath: yaml['fcmKeyFilePath'],
      projectId: yaml['projectId'],
      notificationTitle: yaml['notificationTitle'],
      notificationBody: yaml['notificationBody'],
      androidNotificationOptions:
          Map<String, Object?>.from(yaml['androidNotificationOptions']),
      apnsNotificationOptions:
          Map<String, Object?>.from(yaml['apnsNotificationOptions']),
      debugLogs: yaml['debugLogs'] ?? false,
    );
  }
}
