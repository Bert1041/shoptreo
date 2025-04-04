import 'package:flutter/material.dart';
import 'package:shoptreo/screens/auth/login_screen.dart';
import 'package:shoptreo/screens/auth/signup_screen.dart';
import 'package:shoptreo/shared/widgets/bottom_nav.dart';
import 'package:shoptreo/screens/home_screen.dart';
import 'package:shoptreo/screens/onboarding/onboarding_screen.dart';
import 'package:shoptreo/screens/onboarding/start_screen.dart';
import 'package:shoptreo/screens/product/product_detail_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String start = '/start';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String bottomNav = '/bottom-nav';
  static const String home = '/home';
  static const String discover = '/discover';
  static const String orders = '/orders';
  static const String account = '/account';
  static const String productDetails = '/product-details';

  static Map<String, Widget Function(BuildContext)> routes = {
    onboarding: (_) => const OnboardingScreen(),
    start: (_) => const StartScreen(),
    login: (_) => const LoginScreen(),
    signup: (_) => const SignUpScreen(),
    bottomNav: (_) => const BottomNav(),
    home: (_) => const HomeScreen(),
    productDetails: (_) => const ProductDetailScreen(),
  };
}


