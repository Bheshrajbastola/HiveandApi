import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/config/router/app_route.dart';
import 'package:hiveandapi_clean/features/splash/presentation/viewmodel/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {});
    ref.read(splashViewModelProvider.notifier).init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 200,
                  width: 200,
                  // child: Image.asset('assets/images/splash.png'),
                ),
                Text(
                  'Student Course Management',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('version : 1.0.0')
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Developed by: Khatra Sir le',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
