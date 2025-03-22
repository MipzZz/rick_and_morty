import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'package:rick_and_morty/core/common/bloc/app_bloc_observer.dart';
import 'package:rick_and_morty/features/app/presentation/app.dart';
import 'package:rick_and_morty/features/init/logic/composition_root.dart';

final class AppRunner {
  const AppRunner();

  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

    Bloc.observer = AppBlocObserver();

    final composeRoot = CompositionRoot();

    Future<void> initializeAndRun() async {
      try {
        final result = await composeRoot.compose();
        runApp(App(result));
      } on Object catch (e, s) {
        developer.log('App init failed', error: e, stackTrace: s);
        // runApp(
        //   InitializationFailedApp(
        //     error: e,
        //     stackTrace: s,
        //     retryInitialization: initializeAndRun,
        //   ),
        // );
      } finally {
        binding.allowFirstFrame();
      }
    }

    await initializeAndRun();
  }
}
