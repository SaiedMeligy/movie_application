import 'package:movie_app/models/CategoryFilm.dart';

import '../../../../../models/category_image.dart';

sealed class CategoryStates{}
  class LoadingCategory extends CategoryStates{}
class SuccessCategory extends CategoryStates{
  final List<Categories> category;
  //final List<CategoryImage> categoryImages ;
  SuccessCategory(this.category,);
}
class ErrorCategory extends CategoryStates{
  final String errorMessage;
  ErrorCategory(this.errorMessage);
}