import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/city/city_screen.dart';
import '../screens/place/place_detail_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/planner/planner_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../utils/app_constants.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppConstants.signupRoute,
        name: 'signup',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignupScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomeScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '${AppConstants.cityRoute}/:cityId',
        name: 'city',
        pageBuilder: (context, state) {
          final cityId = state.pathParameters['cityId']!;
          return CustomTransitionPage(
            child: CityScreen(cityId: cityId),
            transitionsBuilder: _slideTransition,
          );
        },
      ),
      GoRoute(
        path: '${AppConstants.placeDetailRoute}/:placeId',
        name: 'place',
        pageBuilder: (context, state) {
          final placeId = state.pathParameters['placeId']!;
          return CustomTransitionPage(
            child: PlaceDetailScreen(placeId: placeId),
            transitionsBuilder: _slideTransition,
          );
        },
      ),
      GoRoute(
        path: AppConstants.chatRoute,
        name: 'chat',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ChatScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: AppConstants.plannerRoute,
        name: 'planner',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const PlannerScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        name: 'profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ProfileScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

Widget _fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) =>
    FadeTransition(opacity: animation, child: child);

Widget _slideTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) =>
    SlideTransition(
      position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    );