import 'package:movie_app/models/ReleaseModel.dart';
import 'package:movie_app/models/SearchModel.dart';

sealed class WatshListState {}
class LoadingState extends WatshListState{}
class SuccessState extends WatshListState{
  final List<ReleaseFilms> movieList;

  SuccessState(this.movieList);
}
class ErrorSearch extends WatshListState{
  final String errorMessage;
  ErrorSearch(this.errorMessage);
}
