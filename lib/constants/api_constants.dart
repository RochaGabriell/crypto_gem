import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = '${dotenv.env['API_URL']}';
  static String apiKey = '${dotenv.env['API_KEY']}';
  static String coinUrl = 'coins/markets';
}
