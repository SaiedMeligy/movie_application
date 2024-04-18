import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_network.dart';

import '../../../models/ReleaseModel.dart';

class ReleasesViewModel extends ChangeNotifier{
  List<ReleaseFilms> _releases = [];
  List<ReleaseFilms> get releases => _releases;
  fetchReleases() async {
    try {
      _releases = await ApiManager.fetchReleases();
      notifyListeners();
    }
    catch (e) {
      print(e);
    }
  }
}