import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String baseUrl = 'http://192.168.6.246:8000';

  static String pusherAppID = dotenv.env['pusherAppID'] ?? '';
  static String pusherApiKey = dotenv.env['pusherApiKey'] ?? '';
  static String pusherSecret = dotenv.env['pusherSecret'] ?? '';
  static String pusherApiCluster = dotenv.env['pusherApiCluster'] ?? '';
}
