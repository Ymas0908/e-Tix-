import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/router/route_name.dart';
import 'package:my_app/views/login/login.dart';

import '../views/splash_view.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteName.defaultRoute,
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: '/login',
      name: RouteName.login,
      builder: (context, state) => Login(),
    ),
    // GoRoute(
    //   path: '/home',
    //   name: RouteName.home,
    //   builder: (context, state) => HomeScreen(),
    // ),

  ],
  redirect: (BuildContext context, GoRouterState state) {
    return null;
  },
);
