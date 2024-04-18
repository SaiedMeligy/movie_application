import 'package:flutter/material.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/features/movieDetails/viewModel/details_view_model.dart';

class GenersMovie extends StatelessWidget {
  final String movie;
  GenersMovie({super.key, required this.movie});
  var viewModel = DetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 30,
      width: 80,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: viewModel.detailsModel.genres != null &&
                  viewModel.detailsModel.genres!.isNotEmpty
              ? Colors.transparent
              : Color(0xff514F4F),
          width: 0.0,
        ),
      ),
      child: Text(
        "${movie}",
        textAlign: TextAlign.center,
        style: Constants.theme.textTheme.bodySmall,
      ),
    );
  }
  getGeners(){
    for(var genre in viewModel.detailsModel.genres??[]){
      GenersMovie(movie:genre.name);
    }
  }
}
