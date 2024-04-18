
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/core/config/routes/page_route_name.dart';
import 'package:movie_app/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
@override
void initState() {
    Timer(const Duration(seconds: 2), () {
      navigatekey.currentState!.pushReplacementNamed(PageRouteName.home);
      //navigatekey.currentState!.pushReplacementNamed(PageRouteName.release);
    });
  }
  @override
  Widget build(BuildContext context) {
    return
        Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/movies.png'),
          alignment: Alignment.center,
        ),
      ),

    );
  }
}
