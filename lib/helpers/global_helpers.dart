import 'package:flutter_dotenv/flutter_dotenv.dart';

class GlobalHelpers {
  void loadEnvVariables() async {
    await dotenv.load(fileName: ".env");
  }
}
