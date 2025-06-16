import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/main_scaffold.dart';
import 'package:mongbi_app/presentation/auth/social_login_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_loading_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_result_page.dart';
import 'package:mongbi_app/presentation/dream/dream_interpretation_page.dart';
import 'package:mongbi_app/presentation/dream/dream_write_page.dart';
import 'package:mongbi_app/presentation/history/history_page.dart';
import 'package:mongbi_app/presentation/home/home_page.dart';
import 'package:mongbi_app/presentation/profile/profile_setting_page.dart';
import 'package:mongbi_app/presentation/remind/remind_time_setting_page.dart';
import 'package:mongbi_app/presentation/remind/remind_time_time_setting_page.dart';
import 'package:mongbi_app/presentation/splash/splash_page.dart';
import 'package:mongbi_app/presentation/statistics/statistics_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/remindtime_setting'),

    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryPage(),
        ),
        GoRoute(
          path: '/statistics',
          builder: (context, state) => const StatisticsPage(),
        ),
        // TODO: 통계 화면, 프로필 화면으로 이동
      ],
    ),
    GoRoute(path: '/splash', builder: (context, state) => SplashPage()),
    GoRoute(
      path: '/social_login',
      builder: (context, state) => SocialLoginPage(),
    ),
    GoRoute(
      path: '/nickname_input',
      builder: (context, state) => NicknameInputPage(),
    ),
    GoRoute(
      path: '/remindtime_setting',
      builder: (context, state) => RemindTimeSettingPage(),
    ),
    GoRoute(
      path: '/remindtime_time_setting',
      builder: (context, state) => RemindTimePickerPage(),
    ),
    
    GoRoute(
      path: '/dream_write',
      builder: (context, state) => DreamWritePage(),
    ),
    GoRoute(
      path: '/dream_analysis_loading',
      builder: (context, state) => DreamAnalysisLoadingPage(),
    ),
    GoRoute(
      path: '/dream_analysis_result',
      builder: (context, state) => DreamAnalysisResultPage(),
    ),
    GoRoute(
      path: '/dream_interpretation',
      builder: (context, state) => DreamInterpretationPage(),
    ),
  ],
);
