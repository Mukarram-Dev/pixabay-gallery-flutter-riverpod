import 'package:pixabay_gallery/config/routes/routes_name.dart';
import 'package:go_router/go_router.dart';
import 'package:pixabay_gallery/views/home/home_view.dart';

import '../../views/login/login_screen.dart';
import '../../views/signup/signup_screen.dart';
import '../../views/splash/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouteName.splashRoute,
      builder: (context, state) => const SplashScreen(),
      name: RouteName.splashRoute,
    ),
    GoRoute(
      path: RouteName.loginRoute,
      builder: (context, state) => const LoginScreen(),
      name: RouteName.loginRoute,
    ),
    GoRoute(
      path: RouteName.signUpRoute,
      builder: (context, state) => const SignUpScreen(),
      name: RouteName.signUpRoute,
    ),
    GoRoute(
      path: RouteName.homeRoute,
      builder: (context, state) => const HomeView(),
      name: RouteName.homeRoute,
    ),
  ],
);
