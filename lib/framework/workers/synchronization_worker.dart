import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:injectable/injectable.dart';
import 'package:noteme/framework/ioc/injection.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/synchronizators/synchronization.dart';
import 'package:noteme/main_init.dart';

@lazySingleton
@injectable
class SynchronizationWorker {
  static final ReceivePort _receivePort = ReceivePort();
  static Isolate _isolate;
  static Timer _timer;

  static bool get started => _timer?.isActive == true;

  static Future<void> start() async {
    if (started) {
      return;
    }

    await startTimer();
  }

  static Future<void> stop() async {
    if (!started) {
      return;
    }

    _timer.cancel();
  }

  static void _runTimer(SendPort sendPort) async {
    startTimer();
  }

  static Future<void> startTimer() async {
    await _synchro();
    _timer = Timer.periodic(new Duration(seconds: 60), (Timer t) async {
      await _synchro();
    });
  }

  static Future _synchro() async {
    try {
      var mainSync = getIt<MainSynchronizator>();
      await mainSync.synchronize();
    } on Exception catch (_) {
      print(_);
    }
  }
}
