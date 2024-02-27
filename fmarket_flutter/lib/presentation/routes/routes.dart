import 'package:go_router/go_router.dart';

import '../pages/cart_list/cart_list_page.dart';
import '../pages/home/home_page.dart';
import '../main/main_screen.dart';
import '../pages/splash/splash_page.dart';
import 'route_path.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: "splash",
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.main,
      name: "home",
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: RoutePath.cart_list,
      name: "cart_list",
      builder: (context, state) => const CartListPage(),
    ),
  ],
  initialLocation: RoutePath.splash,
);
