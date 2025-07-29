import 'package:example/screens/about.dart';
import 'package:example/screens/home.dart';
import 'package:example/screens/settings.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>HomePage(true),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutPage(),
    ),
  ],
);
