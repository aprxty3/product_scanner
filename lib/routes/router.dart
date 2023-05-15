import 'package:go_router/go_router.dart';
import 'package:product_scanner/screen/error_screen.dart';
import 'package:product_scanner/screen/home_screen.dart';
import 'package:product_scanner/screen/setting_screen.dart';

final router = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        path: 'seetings', builder: (context, state) => const SettingScreen()),
  ],
);
