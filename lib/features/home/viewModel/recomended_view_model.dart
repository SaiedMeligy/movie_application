import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/models/RecomendedModel.dart';

class RecomendedViewModel extends ChangeNotifier{
  List<RecommendFilms> _trendList = [];
  List<RecommendFilms> get trendList => _trendList;
  fetchTrending()async {
    try {
      _trendList = await ApiManager.fetchTrending();
      notifyListeners();
    }
    catch (e) {
      print(e);
    }
  }
}