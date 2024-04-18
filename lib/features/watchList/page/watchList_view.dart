import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/watchList/viewModel/watshList_cubit.dart';
import 'package:movie_app/models/ReleaseModel.dart';

import '../../../core/config/routes/page_route_name.dart';
import '../../../core/constants.dart';
import '../viewModel/watchList_state.dart';

class WatchListView extends StatefulWidget {
  const WatchListView({super.key});

  @override
  State<WatchListView> createState() => _WatchListViewState();
}

class _WatchListViewState extends State<WatchListView> {
  var viewModel = WatshListCubit();
  Set<int> uniqueMovieIds = Set<int>(); // Set to store unique movie IDs

  @override
  void initState() {
    super.initState();
    viewModel.getWatchList();
  }

  Widget build(BuildContext context) {
    ReleaseFilms releaseFilms;
    CollectionReference movie =
        FirebaseFirestore.instance.collection(Constants.movieCollection);

    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is SuccessState) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.movieList.length,
                  itemBuilder: (context, index) {
                    var movie = state.movieList[index];

                    return Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PageRouteName.details,
                                arguments: movie,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: Constants.mediaQuery.height * 0.25,
                                      width: Constants.mediaQuery.width * 0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.green.withOpacity(0.5),
                                            width: 2),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          movie.title ?? "",
                                          style: Constants
                                              .theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          )),
                                      Text(movie.releaseDate ?? "",
                                          style: Constants
                                              .theme.textTheme.bodySmall
                                              ?.copyWith(color: Colors.grey)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: Constants.mediaQuery.width *
                                                0.17,
                                            height: 30,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.amber.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        .textTheme.bodyLarge),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Color(0xffFFA90A).withOpacity(0.8),
                                                shape: Border.all(
                                                    color: Colors.blueGrey,
                                                    width: 1
                                                ),
                                                title: const Text('Delete Movie'),
                                                content:  Text(
                                                    'Are you sure you want to delete this movie?',style: Constants.theme.textTheme.bodyLarge,),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancel',style: Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black54),),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await viewModel.deleteReleaseFilm("${movie.id}");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Delete',style: Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black54),),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(Icons.delete,size: 30,)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    );
                  },
                ),
              )
            ]),
          );
        } else if (state is ErrorSearch) {
          // Handle error state
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return Container();
        }
      },
    );
  }
}
