import 'package:flutter/material.dart';
import 'package:katalog_elektronik/screens/beranda/home_screen.dart';
import 'package:katalog_elektronik/screens/beranda/home_screen_viewmodel.dart';
import 'package:katalog_elektronik/auth/login_screen.dart';
import 'package:katalog_elektronik/auth/signup_screen.dart';
import 'package:katalog_elektronik/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signup_screen';
  static const String homeScreen = '/home_screen';


  static Map<String, WidgetBuilder> get routes => {
  splashScreen: (context) => const SplashScreen(),
  loginScreen: (context) => const LoginScreen(),
  signupScreen: (context) => SignupScreen(),
  homeScreen: (context) => HomeScreen(viewModel: HomeScreenViewModel()),
};

}