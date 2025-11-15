import 'package:flutter/material.dart';

import 'core/base/injection.dart';
import 'core/base/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF002053),
          brightness: Brightness.light,
          primary: const Color(0xFF002053),
        ),
        useMaterial3: true,
      ),
      routerConfig: Routers().router,
    );
  }
}
