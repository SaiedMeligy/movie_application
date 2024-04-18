
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/config/routes/page_route_name.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/browse/page/viewModel/category_cubit/category_cubit.dart';
import 'package:movie_app/features/browse/page/viewModel/category_cubit/category_state.dart';
import 'package:movie_app/features/browse/widget/category_View.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/category_image.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({super.key});

  @override
  State<BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  var categoryViewModel = CategoryCubit();

  @override
  void initState() {
    super.initState();
    categoryViewModel.getCategory();

  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:60 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Browse Category ",style: Constants.theme.textTheme.titleLarge,),
          BlocBuilder(
            bloc: categoryViewModel,
            builder: (context, state) {
              ApiManager.fetchCategory();
              switch (state) {
                case LoadingCategory():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SuccessCategory( ):
                  {
                    List<CategoryImage> categoryImages =state.category.map((category) {
                      return CategoryImage(
                        id: category.id,
                          image: "assets/images/category/${category.name}.jpg", title: category.name ?? "");}).toList();

                    var categoryList = categoryImages;
                    return
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.9,
                          children: categoryList
                              .map(
                                (category) =>
                                GridTile(
                                  child: GestureDetector(
                                    onTap: () {
                                      navigatekey.currentState!.pushNamed(PageRouteName.related,
                                         arguments: category.id
                                      );
                                      print(category.id);

                                    },
                                    child: CategoryView(
                                      title: category.title??"",
                                      image:category.image,

                                    ),
                                  )
                                ),
                          )
                              .toList(),
                        ),
                      );
                  }
                case ErrorCategory():
                  return Center(
                    child: Text(state.errorMessage),
                  );
                default:
                  return Container();
              }
            }
          ),
        ],
      ),
    );
  }

}
