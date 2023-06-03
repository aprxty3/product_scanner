import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:product_scanner/screen/detail_prodcut_screen.dart';
import 'package:product_scanner/screen/error_screen.dart';
import 'package:product_scanner/screen/home_screen.dart';
import 'package:product_scanner/screen/login_screen.dart';
import 'package:product_scanner/screen/product_screen.dart';
import 'package:product_scanner/screen/add_product_screen.dart';
export 'package:go_router/go_router.dart';
part 'routes_name.dart';

final router = GoRouter(
  redirect: (context, state) {
    FirebaseAuth auth = FirebaseAuth.instance;
    print(auth.currentUser);
    if (auth.currentUser == null) {
      return '/login';
    } else {
      return null;
    }
  },
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
                  state.extra,
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'addProduct',
            name: Routes.addProduct,
            builder: (context, state) => AddProductScreen(),
          ),
        ]),
    GoRoute(
        path: '/login',
        name: Routes.login,
        builder: (context, state) => LoginScreen()),
  ],
);
