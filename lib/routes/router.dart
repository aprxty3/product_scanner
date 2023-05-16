import 'package:go_router/go_router.dart';
import 'package:product_scanner/screen/detail_prodcut_screen.dart';
import 'package:product_scanner/screen/error_screen.dart';
import 'package:product_scanner/screen/home_screen.dart';
import 'package:product_scanner/screen/product_screen.dart';
import 'package:product_scanner/screen/setting_screen.dart';
export 'package:go_router/go_router.dart';
// part 'routes_name.dart';

final router = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
              path: 'product',
              builder: (context, state) => const ProductScreen(),
              routes: [
                GoRoute(
                    path: 'detailProduct',
                    builder: (context, state) => const DetailProductScreen()),
              ]),
        ]),
    GoRoute(
        path: '/setings', builder: (context, state) => const SettingScreen()),
  ],
);
