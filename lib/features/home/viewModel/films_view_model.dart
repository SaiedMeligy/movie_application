import 'package:flutter/cupertino.dart';
import '../../../../models/PosterModel.dart';
import 'package:movie_app/core/network/api_network.dart';


class FilmsViewModel extends ChangeNotifier {
  List<Results> _results = [];
  List<Results> get results => _results;
  fetchPosters() async {
    try {
      _results = await ApiManager.fetchPosters();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
