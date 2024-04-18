

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/browse/page/viewModel/related_cubit/related_state.dart';

class RelatedCubit extends Cubit<RelatedState> {
  RelatedCubit() : super(LoadingState());

  void getRelatedMovies(int id) async {
    try{
    emit(LoadingState());
    final relatedMovie = await ApiManager.fetchRelatedMovie(id);
    emit(SuccessState(relatedMovie));
  } catch(error){
  emit(ErrorState(error.toString()));
  print(error.toString());
  }
}
}