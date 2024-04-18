import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/SimilarMovieModel.dart';
import '../../../models/DetailsModel.dart';
import 'package:movie_app/core/network/api_network.dart';

class DetailsViewModel extends ChangeNotifier {
  DetailsModel _detailsModel = DetailsModel();
  DetailsModel get detailsModel => _detailsModel;
  bool isLoading = true;
  Future<void> fetchDetails(int id) async {
    try {
      _detailsModel = await ApiManager.fetchDetailsMovie(id);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
