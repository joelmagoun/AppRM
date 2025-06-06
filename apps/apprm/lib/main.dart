import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bootstrap/bootstrap.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: rootRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff5272F2)),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
    );
  }
}
