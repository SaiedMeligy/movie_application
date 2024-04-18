import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/watchList/viewModel/watchList_state.dart';

import '../../../core/constants.dart';
import '../../../models/ReleaseModel.dart';

class WatshListCubit extends Cubit<WatshListState> {
  WatshListCubit() : super(LoadingState());

  Future<void> getWatchList() async {
    try {
      emit(LoadingState());
      CollectionReference movie =
      FirebaseFirestore.instance.collection(Constants.movieCollection);
      final snapshot = await movie.get();
      List<ReleaseFilms> movieList = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        movieList.add(ReleaseFilms.fromJson(snapshot.docs[i]));
      // if (snapshot.docs.isNotEmpty) {
      //   final movieList = snapshot.docs
      //       .map((doc) => ReleaseFilms.fromJson(doc.data()))
      //       .toList();

      }
      emit(SuccessState(movieList));
    }
    catch (e) {
      // Handle error
      print('Error fetching movies: $e');
    }
  }

  Future<void> deleteReleaseFilm(String id) async {

    try {

      CollectionReference moviesCollection = FirebaseFirestore.instance.collection(Constants.movieCollection);
      DocumentReference filmReference = moviesCollection.doc(id);
      await filmReference.delete();
      emit(SuccessState([]));
      print('Document with ID $id deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');

    }
  }


}
