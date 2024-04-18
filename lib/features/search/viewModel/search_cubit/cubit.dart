import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/search/viewModel/search_cubit/states.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit():super(LoadingSearch());
  getMovie(String query)async{
    try{
      emit(LoadingSearch());
      final movieList = await ApiManager.fetchMovies(query);
      emit(SuccessSearch(movieList));
    }catch(error)
    {
      emit(ErrorSearch(error.toString()));
      print(error.toString());
    }

  }

}