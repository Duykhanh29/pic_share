import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String baseUrl = 'http://192.168.53.101:8000';

  static String pusherAppID = dotenv.env['pusherAppID'] ?? '';
  static String pusherApiKey = dotenv.env['pusherApiKey'] ?? '';
  static String pusherSercet = dotenv.env['pusherSercet'] ?? '';
  static String pusherApiCluster = dotenv.env['pusherApiCluster'] ?? '';
}
