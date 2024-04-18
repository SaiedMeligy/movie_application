import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';

class Constants{
  static const String api_key="c0f74e548e7076e4d2dc0d617a68d604";
  static const baseUrl="https://api.themoviedb.org/3/movie";
  static const String access_token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMGY3NGU1NDhlNzA3NmU0ZDJkYzBkNjE3YTY4ZDYwNCIsInN1YiI6IjY1ZjFhODFiMDZmOTg0MDE4NTQ0NjVkMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIaztNacIWJz1STF5KYXJTomfcZbLtfYIUsIOzCoFaA";
  static var  mediaQuery=MediaQuery.of(navigatekey.currentState!.context).size;
  static var theme=Theme.of(navigatekey.currentState!.context);
  static const movieCollection='movies';
}
