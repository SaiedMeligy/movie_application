import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/search/viewModel/search_cubit/cubit.dart';
import 'package:movie_app/features/search/viewModel/search_cubit/states.dart';
import 'package:movie_app/models/ReleaseModel.dart';
import 'package:movie_app/models/SearchModel.dart';

import '../../../core/config/routes/page_route_name.dart';
import '../../../main.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var cubitViewModel = SearchCubit();
  String val = "";
  List<SearchList> searchResult = [];
  final TextEditingController searchText = TextEditingController();
  @override
  void initState() {
    super.initState();
    cubitViewModel.getMovie(val);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(40.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff514F4F), // Set the background color here
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: TextField(
              controller: searchText,
              onChanged: (value) {
                cubitViewModel.getMovie(value);
                setState(() {
                  searchResult.clear();
                  val = value;
                });
              },
              onSubmitted: (value) {
                cubitViewModel.getMovie(value);
                searchResult.clear();
                setState(() {
                  val = value;
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.white54)),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: InputBorder.none, // Remove the border of the TextField
              ),
              style: TextStyle(color: Colors.white), // Set text color
            ),
          ),
        ),
        BlocBuilder<SearchCubit, SearchState>(
            bloc: cubitViewModel,
            builder: (context, state) {
              if (state is LoadingSearch) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuccessSearch) {
                // Handle success state
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      var movie = state.movies[index];
                      return Column(
                        children: [
                          // ListTile(
                          //   onTap: () {
                          //     ReleaseFilms releaseFilms=ReleaseFilms();
                          //     releaseFilms.id= movie.id;
                          //     Navigator.of(context).pushNamed(
                          //       PageRouteName.details,
                          //       arguments: releaseFilms,
                          //     );
                          //   },
                          //   leading: SizedBox(
                          //     height: Constants.mediaQuery.height,
                          //     width: 130,
                          //     child: CachedNetworkImage(
                          //       imageUrl:
                          //           "https://image.tmdb.org/t/p/original/${movie.posterPath}", // Set imageUrl to empty string if posterPath is null
                          //       imageBuilder: (context, imageProvider) =>
                          //           Container(
                          //         height: 250,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(15),
                          //           border: Border.all(
                          //               color:
                          //                   Color(0xffFFA90A).withOpacity(0.6),
                          //               width: 1),
                          //           image: DecorationImage(
                          //             image: imageProvider,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //       ),
                          //       placeholder: (context, url) => const Center(
                          //           child: CircularProgressIndicator()),
                          //       errorWidget: (context, url, error) =>
                          //           const Icon(Icons.error,
                          //               size: 60, color: Colors.grey),
                          //     ),
                          //   ),
                          //
                          //   //Image.network(_normalizeUrl("https://image.tmdb.org/t/p/original/${movie.posterPath}}"??"}"),),
                          //
                          //   title: Text(
                          //     movie.title ?? "",
                          //     style: Constants.theme.textTheme.bodyLarge,
                          //   ),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         movie.releaseDate ?? "",
                          //         style: Constants.theme.textTheme.bodySmall
                          //             ?.copyWith(color: Colors.grey),
                          //       ),
                          //       Text(
                          //         movie.originalTitle ?? "",
                          //         style: Constants.theme.textTheme.bodySmall
                          //             ?.copyWith(
                          //                 color: Colors.grey,
                          //                 overflow: TextOverflow.ellipsis),
                          //       ),
                          //       Row(
                          //         children: [
                          //           Container(
                          //             width: Constants.mediaQuery.width * 0.17,
                          //             height: 30,
                          //             padding: const EdgeInsets.all(5),
                          //             decoration: BoxDecoration(
                          //               color: Colors.amber.withOpacity(0.2),
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 const Icon(
                          //                   Icons.star,
                          //                   color: Colors.amber,
                          //                   size: 20,
                          //                 ),
                          //                 const SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   "${movie.voteAverage?.toStringAsFixed(1)}",
                          //                   style: Constants
                          //                       .theme.textTheme.bodySmall,
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 5,
                          //           ),
                          //           Container(
                          //             width: Constants.mediaQuery.width * 0.25,
                          //             height: 30,
                          //             padding: EdgeInsets.all(5),
                          //             decoration: BoxDecoration(
                          //               color: Colors.amber.withOpacity(0.2),
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 const Icon(
                          //                   Icons.people_outline_sharp,
                          //                   color: Colors.amber,
                          //                   size: 20,
                          //                 ),
                          //                 const SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   "${movie.popularity}",
                          //                   style: Constants
                          //                       .theme.textTheme.bodySmall,
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          //   // Other movie details...
                          // ),
                          InkWell(
                            onTap: () {
                              ReleaseFilms releaseFilms=ReleaseFilms();
                                  releaseFilms.id= movie.id;
                                  Navigator.of(context).pushNamed(
                                    PageRouteName.details,
                                    arguments: releaseFilms,
                                  );
                            },
                            child: Container(
                              height: Constants.mediaQuery.height * 0.2,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xff25233D).withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      //color: Colors.green.shade200
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
                                      Text(
                                                movie.originalTitle ?? "",
                                                style: Constants.theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey,
                                                        overflow: TextOverflow.ellipsis),
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
                          ),
                          const Divider(
                            thickness: 2,
                            indent: 30,
                            endIndent: 30,
                            color: Color(0xff707070),
                          )
                        ],
                      );
                    },
                  ),
                );
              } else if (state is ErrorSearch) {
                // Handle error state
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else {
                return Container();
              }
            }),
      ],
    );
  }
  // String _normalizeUrl(String url) {
  //   // Remove any extra slashes from the URL
  //   return url.replaceAll(RegExp(r'https://+'), 'https://');
  // }
}
