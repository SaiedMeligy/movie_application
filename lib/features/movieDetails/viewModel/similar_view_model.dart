import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/SimilarMovieModel.dart';
import '../../../models/DetailsModel.dart';
import 'package:movie_app/core/network/api_network.dart';

class SimilarViewModel extends ChangeNotifier {
  SimilarMovieModel _similarMovieModel =SimilarMovieModel();
  SimilarMovieModel get similarMovieModel => _similarMovieModel;

  Future<void> fetchSimilarMovie(int id)async{
    try {
      _similarMovieModel = await ApiManager.fetchSimilarMovie(id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
