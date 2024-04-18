import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/features/browse/page/related_movie.dart';
import 'package:movie_app/features/splash/splash_view.dart';
import 'package:movie_app/features/home/page/home_view.dart';
import 'package:movie_app/features/home/widget/new_releases.dart';
import 'package:movie_app/core/config/routes/page_route_name.dart';
import 'package:movie_app/features/movieDetails/page/details_view.dart';
import 'package:movie_app/models/RelatedMovie.dart';

import '../../../features/search/page/search_view.dart';
import '../../../features/watchList/page/watchList_view.dart';
import '../../../models/ReleaseModel.dart';

class Routes{
static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(builder: (context) => SplashView(),settings: settings);
      case PageRouteName.home:
        return MaterialPageRoute(builder: (context) => HomeView(),settings: settings);
      case PageRouteName.release:
        return MaterialPageRoute(builder: (context) => NewReleases(),settings: settings);
      case PageRouteName.details:
        return MaterialPageRoute(builder: (context) => MovieDetails(releaseFilm: settings.arguments as ReleaseFilms,),settings: settings);
      case PageRouteName.details:
        return MaterialPageRoute(builder: (context) => SearchView(),settings: settings);
        case PageRouteName.related:
          return MaterialPageRoute(builder: (context) =>  RelatedView(categoryId: settings.arguments as int),settings: settings);

      case PageRouteName.watshList:
        return MaterialPageRoute(builder: (context) => const WatchListView(),settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => HomeView());
    }
  }
}