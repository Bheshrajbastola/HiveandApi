import 'package:flutter/material.dart';
import 'package:hiveandapi_clean/config/router/app_route.dart';
import 'package:hiveandapi_clean/config/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: AppTheme.getApplicationTheme(),
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
