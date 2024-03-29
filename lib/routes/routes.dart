import 'package:flutter/material.dart';
import 'package:myfundsuthm/ui/screens/auth/signup_screen.dart';
import 'package:myfundsuthm/ui/screens/initial/welcome_screen.dart';

import 'package:myfundsuthm/ui/screens/tab/create_campaign/start_campaign_screen.dart';

import '../ui/screens/auth/forgetpw_screen.dart';
import '../ui/screens/auth/login_screen.dart';

import '../ui/screens/initial/spash_screen.dart';
import '../ui/screens/tab/create_campaign/step_four_screen.dart';
import '../ui/screens/tab/create_campaign/step_one_screen.dart';
import '../ui/screens/tab/create_campaign/step_three_screen.dart';
import '../ui/screens/tab/create_campaign/step_two_screen.dart';

import '../ui/screens/tab/tab_screen.dart';

class RouteGenerator {
  // static const String mainPage = '/homescreen';
  static const String main = '/tab_screen';
  static const String forgetPw = '/forget_pw_screen';
  static const String login = '/login_screen';
  static const String onboarding = '/onboarding_screen';
  static const String splash = '/';
  static const String signup = '/signup_screen';
  static const String details = '/details_screen';
  static const String donation = '/donation_screen';
  static const String result = '/result_screen';
  static const String startCharity = '/start_charity_screen';
  static const String stepOne = '/step_one_screen';
  static const String stepTwo = '/step_two_screen';
  static const String stepThree = '/step_three_screen';
  static const String stepFour = '/step_four_screen';
  static const String welcomeScreen = '/welcome_screen';
  static const String homepage = '/homepage';
  static const String cuba = '/cuba';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case homepage:
        return MaterialPageRoute(
          builder: (_) => TabScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case forgetPw:
        return MaterialPageRoute(
          builder: (_) => const ForgetPwScreen(),
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => const TabScreen(),
        );
      // case details:
      //   return MaterialPageRoute(
      //     builder: (_) => DetailScreen(settings.arguments as Urgent),
      //   );

      case startCharity:
        return MaterialPageRoute(
          builder: (_) => StartCampaign(),
        );
      case stepOne:
        return MaterialPageRoute(
          builder: (_) => StepOneScreen(),
        );
      case stepTwo:
        return MaterialPageRoute(
          builder: (_) => StepTwoScreen(),
        );
      case stepThree:
        return MaterialPageRoute(
          builder: (_) => StepThreeScreen(),
        );
      case stepFour:
        return MaterialPageRoute(
          builder: (_) => StepFourScreen(),
        );
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
        );
      default:
        throw RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
