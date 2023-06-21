import 'package:hiveandapi_clean/features/auth/presentation/view/login_view.dart';
import 'package:hiveandapi_clean/features/auth/presentation/view/register_view.dart';
import 'package:hiveandapi_clean/features/home/presentation/view/home_view.dart';
import 'package:hiveandapi_clean/features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginScreen(),
      homeRoute: (context) => const HomeView(),
      registerRoute: (context) => const RegisterScreen(),
    };
  }
}
