import 'package:movie_app/features/watchList/viewModel/watchList_state.dart';

import '../../../../../models/RelatedMovie.dart';

sealed class RelatedState{}
class LoadingState extends RelatedState{}
class SuccessState extends RelatedState{
  final List<Related> relatedMovies;
  SuccessState(this.relatedMovies);
}
class ErrorState extends RelatedState{
  final String message;
  ErrorState(this.message);
}
