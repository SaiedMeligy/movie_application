import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/browse/page/viewModel/related_cubit/related_cubit.dart';
import 'package:movie_app/features/browse/page/viewModel/related_cubit/related_state.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/ReleaseModel.dart';

import '../../../core/config/routes/page_route_name.dart';
import '../../../core/constants.dart';
import '../../../models/RelatedMovie.dart';
import '../../movieDetails/page/details_view.dart';

class RelatedView extends StatefulWidget {
  final int categoryId;
  RelatedView({super.key, required this.categoryId});

  @override
  State<RelatedView> createState() => _RelatedViewState();
}

class _RelatedViewState extends State<RelatedView> {
  var viewModel = RelatedCubit();
  @override
  void initState() {
    super.initState();
    viewModel.getRelatedMovies(widget.categoryId);
  }

  Widget build(BuildContext context) {
    // print("movie is fetshed");
    // ApiManager.fetchSimilarMovie(28);
    return BlocBuilder<RelatedCubit, RelatedState>(
        bloc: viewModel,
        builder: (context, state) {
          switch (state) {
            case SuccessState():
              {
                //var movieList = state.relatedMovies;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.relatedMovies.length,
                        itemBuilder: (context, index) {
                          var movie = state.relatedMovies[index];
                          return GestureDetector(
                            onTap: (){
                              ReleaseFilms releaseFilms =ReleaseFilms();
                              releaseFilms.id=movie.id;
                              navigatekey.currentState!.pushReplacementNamed(PageRouteName.details,arguments:releaseFilms );
                            },
                            child: Column(
                                children: [
                                Container(
                                  height: Constants.mediaQuery.height * 0.2,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff25233D).withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                      color: Colors.green.shade200
                                    )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: Constants.mediaQuery.height * 0.3,
                                          width: 130,
                                          child:
                                          CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/original/${movie.posterPath}", // Set imageUrl to empty string if posterPath is null
                                            imageBuilder: (context, imageProvider) =>
                                                Container(
                                              height: 250,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Color(0xffFFA90A)
                                                        .withOpacity(0.6),
                                                    width: 1),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error,
                                                    size: 60, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                movie.title ?? "",
                                                style: Constants
                                                    .theme.textTheme.bodyLarge,
                                              ),
                                              Text(
                                                movie.releaseDate ?? "",
                                                style: Constants
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(color: Colors.grey),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        Constants.mediaQuery.width *
                                                            0.17,
                                                    height: 30,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${movie.voteAverage?.toStringAsFixed(1)}",
                                                          style: Constants.theme
                                                              .textTheme.bodySmall,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: Constants.mediaQuery.width*0.25,
                                                    height: 30,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.people_outline_sharp,color: Colors.amber,size: 20,),
                                                        SizedBox(width: 5,),
                                                        Expanded(child: Text("${movie.popularity}",style: Constants.theme.textTheme.bodySmall,))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                            ]),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            case LoadingState():
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ErrorState():
              {
                return Center(child: Text(state.message));
              }
          }
        });
  }
}
