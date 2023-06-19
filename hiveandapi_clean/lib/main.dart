import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/app.dart';
import 'package:hiveandapi_clean/core/network/local/hive_service.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();
  // HiveService().deleteHive();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

