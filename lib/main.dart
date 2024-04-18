import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/config/app_theme_manager.dart';
import 'package:movie_app/core/config/routes/page_route_name.dart';
import 'package:movie_app/core/config/routes/routes.dart';
import 'package:movie_app/features/splash/splash_view.dart';

import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatekey= GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:AppThemeManager.darkTheme,
      home: SplashView(),
      initialRoute: PageRouteName.initial,
      onGenerateRoute:Routes.onGenerateRoute,
      navigatorKey: navigatekey,
    );
  }
}

