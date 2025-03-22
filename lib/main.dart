import 'dart:async';
import 'dart:developer' as developer;
import 'package:rick_and_morty/features/app/di/app_runner.dart';

void main() {
  runZonedGuarded(AppRunner().initializeAndRun, (e, s) {
    developer.log(e.toString(), stackTrace: s);
  });
}
