import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/custom_transition_page.dart';
import 'package:mongbi_app/core/main_scaffold.dart';
import 'package:mongbi_app/presentation/auth/social_login_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_loading_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_result_page.dart';
import 'package:mongbi_app/presentation/dream/dream_interpretation_page.dart';
import 'package:mongbi_app/presentation/dream/dream_write_page.dart';
import 'package:mongbi_app/presentation/history/history_page.dart';
import 'package:mongbi_app/presentation/home/home_page.dart';
import 'package:mongbi_app/presentation/remind/remind_time_setting_page.dart';
import 'package:mongbi_app/presentation/remind/remind_time_time_setting_page.dart';
import 'package:mongbi_app/presentation/setting/alarm_setting_page.dart';
import 'package:mongbi_app/presentation/setting/nickname_input_page.dart';
import 'package:mongbi_app/presentation/setting/profile_setting_page.dart';
import 'package:mongbi_app/presentation/setting/setting_page.dart';
import 'package:mongbi_app/presentation/splash/splash_page.dart';
import 'package:mongbi_app/presentation/statistics/statistics_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/splash'),

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
        GoRoute(path: '/setting', builder: (context, state) => SettingPage()),
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
      path: '/remindtime_setting',
      builder: (context, state) => RemindTimeSettingPage(),
    ),
    GoRoute(
      path: '/remindtime_time_setting',
      builder: (context, state) => RemindTimePickerPage(),
    ),
    
    GoRoute(
      path: '/dream_write',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamWritePage(),
          ),
    ),
    GoRoute(
      path: '/dream_analysis_loading',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamAnalysisLoadingPage(),
          ),
    ),
    GoRoute(
      path: '/dream_analysis_result',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamAnalysisResultPage(),
          ),
    ),
    GoRoute(
      path: '/dream_interpretation',
      builder: (context, state) => DreamInterpretationPage(),
    ),
    GoRoute(
      path: '/profile_setting',
      builder: (context, state) => ProfileSettingPage(),
    ),
    GoRoute(
      path: '/alarm_setting',
      builder: (context, state) => AlarmSettingPage(),
    ),
  ],
);