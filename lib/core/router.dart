import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/custom_transition_page.dart';
import 'package:mongbi_app/core/main_scaffold.dart';
import 'package:mongbi_app/core/responsive_layout.dart';
import 'package:mongbi_app/core/route_observer.dart';
import 'package:mongbi_app/presentation/alarm/alarm_page.dart';
import 'package:mongbi_app/presentation/auth/social_login_page.dart';
import 'package:mongbi_app/presentation/challenge/challenge_intro_page.dart';
import 'package:mongbi_app/presentation/challenge/challenge_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_loading_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_result_page.dart';
import 'package:mongbi_app/presentation/dream/dream_interpretation_page.dart';
import 'package:mongbi_app/presentation/dream/dream_intro_page.dart';
import 'package:mongbi_app/presentation/dream/dream_write_page.dart';
import 'package:mongbi_app/presentation/history/history_page.dart';
import 'package:mongbi_app/presentation/home/home_page.dart';
import 'package:mongbi_app/presentation/onboarding/onbording_exit_page.dart';
import 'package:mongbi_app/presentation/onboarding/onbording_page.dart';
import 'package:mongbi_app/presentation/payment/payment_page.dart';
import 'package:mongbi_app/presentation/remind/remind_time_setting_page.dart';
import 'package:mongbi_app/presentation/remind/remind_time_time_setting_page.dart';
import 'package:mongbi_app/presentation/setting/alarm_setting_page.dart';
import 'package:mongbi_app/presentation/setting/nickname_input_page.dart';
import 'package:mongbi_app/presentation/setting/profile_setting_page.dart';
import 'package:mongbi_app/presentation/setting/setting_page.dart';
import 'package:mongbi_app/presentation/setting/widgets/open_source_license_page.dart';
import 'package:mongbi_app/presentation/splash/splash_page.dart';
import 'package:mongbi_app/presentation/statistics/statistics_page.dart';

final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
final GoRouter router = GoRouter(
  observers: [
    FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
    routeObserver,
  ],
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/shop'),

    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: '/history',
          pageBuilder:
              (context, state) => NoTransitionPage(child: HistoryPage()),
        ),
        GoRoute(
          path: '/statistics',
          pageBuilder:
              (context, state) => NoTransitionPage(child: StatisticsPage()),
        ),
        GoRoute(
          path: '/setting',
          pageBuilder:
              (context, state) => NoTransitionPage(child: SettingPage()),
        ),
      ],
    ),
    GoRoute(path: '/splash', builder: (context, state) => SplashPage()),
    GoRoute(
      path: '/social_login',
      builder: (context, state) => ResponsiveLayout(child: SocialLoginPage()),
    ),
    GoRoute(
      path: '/nickname_input',
      builder: (context, state) => ResponsiveLayout(child: NicknameInputPage()),
    ),
    GoRoute(
      path: '/remindtime_setting',
      builder:
          (context, state) => ResponsiveLayout(child: RemindTimeSettingPage()),
    ),

    GoRoute(
      path: '/remindtime_time_setting',
      builder:
          (context, state) => ResponsiveLayout(
            child: RemindTimePickerPage(
              isRemindEnabled: bool.tryParse(
                '${state.uri.queryParameters['isRemindEnabled']}',
              ),
            ),
          ),
    ),
    GoRoute(
      path: '/onbording_page',
      builder: (context, state) => ResponsiveLayout(child: OnboardingPage()),
    ),
    GoRoute(
      path: '/onbording_exit_page',
      builder:
          (context, state) => ResponsiveLayout(child: OnboardingExitPage()),
    ),
    GoRoute(
      path: '/dream_intro',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamIntroPage(),
          ),
    ),
    GoRoute(
      path: '/dream_write',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamWritePage(
              isFirst:
                  bool.tryParse('${state.uri.queryParameters['isFirst']}') ??
                  true,
            ),
          ),
    ),
    GoRoute(
      path: '/dream_analysis_loading',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamAnalysisLoadingPage(
              isFirst:
                  bool.tryParse('${state.uri.queryParameters['isFirst']}') ??
                  true,
            ),
          ),
    ),
    GoRoute(
      path: '/dream_analysis_result',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: DreamAnalysisResultPage(
              isFirst:
                  bool.tryParse('${state.uri.queryParameters['isFirst']}') ??
                  true,
            ),
          ),
    ),
    GoRoute(
      path: '/dream_interpretation',
      builder:
          (context, state) => ResponsiveLayout(
            child: DreamInterpretationPage(
              isFirst:
                  bool.tryParse('${state.uri.queryParameters['isFirst']}') ??
                  true,
            ),
          ),
    ),
    GoRoute(
      path: '/challenge_intro',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: ChallengeIntroPage(),
          ),
    ),
    GoRoute(
      path: '/challenge',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            key: state.pageKey,
            child: ChallengePage(),
          ),
    ),
    GoRoute(
      path: '/profile_setting',
      builder:
          (context, state) => ResponsiveLayout(child: ProfileSettingPage()),
    ),
    GoRoute(
      path: '/alarm_setting',
      builder: (context, state) => ResponsiveLayout(child: AlarmSettingPage()),
    ),
    GoRoute(path: '/alarm', builder: (context, state) => AlarmPage()),
    GoRoute(
      path: '/license_page',
      builder:
          (context, state) => ResponsiveLayout(child: OpenSourceLicensePage()),
    ),
    GoRoute(
      path: '/shop',
      builder:
          (context, state) => ResponsiveLayout(child: PaymentPage()),
    ),
  ],
);
