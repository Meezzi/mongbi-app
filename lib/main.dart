import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mongbi_app/core/router.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/providers/background_music_provider.dart';
import 'package:mongbi_app/providers/setting_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();
  await dotenv.load(fileName: '.env');
  // 캘린더 한글화
  await initializeDateFormatting();

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
    javaScriptAppKey: dotenv.env['KAKAO_JAVA_SCRIPT_APP_KEY'],
  );

  runApp(const ProviderScope(child: MyApp()));
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
      bgm.resumeBgm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(fontFamily: 'NanumSquareRound'),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
