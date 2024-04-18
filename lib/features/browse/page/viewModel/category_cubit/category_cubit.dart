import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/browse/page/viewModel/category_cubit/category_state.dart';

import '../../../../../models/category_image.dart';

class CategoryCubit extends Cubit<CategoryStates>{
  CategoryCubit() : super(LoadingCategory());

  void getCategory() async {
    try{
  emit(LoadingCategory());
  final category = await ApiManager.fetchCategory();
  emit(SuccessCategory(category,));
  }catch(error){
  emit(ErrorCategory(error.toString()));
  print(error.toString());
  }
  }
}