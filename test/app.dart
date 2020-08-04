import 'dart:async';

import 'package:inscritus/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';
import 'package:inscritus/repositories/user_repository.dart';

void main() {
  // ignore: missing_return
  Future<String> dataHandler(String msg) async {}

  enableFlutterDriverExtension(handler: dataHandler);

  // Replace all of these by their mocks, eventually
  final UserRepository userRepository = UserRepository();

  app.mainTest(
    userRepository,
  );
}
