import 'package:go_router/go_router.dart';
import 'package:product_scanner/screen/detail_prodcut_screen.dart';
import 'package:product_scanner/screen/error_screen.dart';
import 'package:product_scanner/screen/home_screen.dart';
import 'package:product_scanner/screen/product_screen.dart';
import 'package:product_scanner/screen/setting_screen.dart';
export 'package:go_router/go_router.dart';
part 'routes_name.dart';

final router = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
        path: '/',
        name: Routes.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
              path: 'product',
              name: Routes.product,
              builder: (context, state) => const ProductScreen(),
              routes: [
                GoRoute(
                    path: ':id',
                    name: Routes.detailProduct,
                    builder: (context, state) => DetailProductScreen(
                          state.pathParameters['id'].toString(),
                          state.queryParameters,
                        )),
              ]),
        ]),
    GoRoute(
        path: '/setings',
        name: Routes.setting,
        builder: (context, state) => const SettingScreen()),
  ],
);
