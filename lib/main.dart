import 'package:flutter/material.dart';

import 'package:enmu_mobile/widgets/nav_bar_handler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  runApp(const MyApp());

// whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 101, 51, 1),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(0, 101, 51, 1),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      home: const NavBarHandler(),
    );
  }
}
