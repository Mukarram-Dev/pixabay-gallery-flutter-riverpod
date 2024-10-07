import 'package:pixabay_gallery/config/routes/routes_name.dart';
import 'package:go_router/go_router.dart';
import 'package:pixabay_gallery/views/home/home_view.dart';

import '../../views/splash/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouteName.splashRoute,
      builder: (context, state) => const SplashScreen(),
      name: RouteName.splashRoute,
    ),
    GoRoute(
      path: RouteName.homeRoute,
      builder: (context, state) => const HomeView(),
      name: RouteName.homeRoute,
    ),
  ],
);
