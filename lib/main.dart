import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mongbi_app/core/router.dart';
import 'package:mongbi_app/firebase_optiopns.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/providers/background_music_provider.dart';
import 'package:mongbi_app/providers/setting_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await dotenv.load(fileName: '.env');
  // 캘린더 한글화
  await initializeDateFormatting();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
    javaScriptAppKey: dotenv.env['KAKAO_JAVA_SCRIPT_APP_KEY'],
  );
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://8d16495c497563cc341db965785f3374@o4509553500422144.ingest.de.sentry.io/4509553530830928';

      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner:
        () => runApp(SentryWidget(child: const ProviderScope(child: MyApp()))),
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runZonedGuarded(() => runApp(const ProviderScope(child: MyApp())), (
    error,
    stackTrace,
  ) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final isBgmOn = ref.read(bgmProvider);
    if (isBgmOn) {
      ref.read(backgroundMusicProvider).playBgm();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ref.read(backgroundMusicProvider).dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bgm = ref.read(backgroundMusicProvider);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      bgm.fadeOutAndPause();
    } else if (state == AppLifecycleState.resumed) {
      final isBgmOn = ref.read(bgmProvider);
      if (isBgmOn) {
        bgm.resumeBgm();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(fontFamily: 'NanumSquareRound'),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
