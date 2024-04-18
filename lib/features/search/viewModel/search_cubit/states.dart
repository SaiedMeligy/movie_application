import 'package:movie_app/models/SearchModel.dart';

sealed class SearchState {}
class LoadingSearch extends SearchState{}
class SuccessSearch extends SearchState{
  final List<SearchList> movies;
  SuccessSearch(this.movies);
}
class ErrorSearch extends SearchState{
  final String errorMessage;
  ErrorSearch(this.errorMessage);
}
