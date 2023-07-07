import 'dart:async';
import 'dart:developer';

import 'package:airship_flutter/airship_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_to_app/utils/log_helper.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      (() async {
        const appKey = 'dB2oMXOIQGyx8baqBuhs2A';
        const appSecret = 'SBjuD6N3SMuYcIkZNs06CQ';
        await Airship.takeOff(appKey, appSecret);

        Airship.setUserNotificationsEnabled(true);
        // Airship.onPushReceived
        //     .listen((event) => logger.d('Push Received $event'));

        // Airship.onNotificationResponse
        //     .listen((event) => logger.d('Notification Response $event'));

        Airship.setNamedUser('test_user');
        final id = await Airship.channelId;

        logger.d({"id": id});
      })();

      return runApp(await builder());
    },
    (error, stackTrace) async {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}
