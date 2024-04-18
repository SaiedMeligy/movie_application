
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/features/movieDetails/viewModel/similar_view_model.dart';
import 'package:movie_app/models/DetailsModel.dart';
import 'package:provider/provider.dart';

class SimilarMovie extends StatefulWidget {
  final DetailsModel detailsFilms;
  const SimilarMovie({super.key,required this.detailsFilms});

  @override
  State<SimilarMovie> createState() => _SmilarMovieState();
}

class _SmilarMovieState extends State<SimilarMovie> {
  var viewModel= SimilarViewModel();
  int tappedIndex = -1;
  CollectionReference movie =
  FirebaseFirestore.instance.collection(Constants.movieCollection);
  @override
  void initState() {
    super.initState();
    viewModel.fetchSimilarMovie(widget.detailsFilms.id!);
  }
  Widget build(BuildContext context) {

    return  ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SimilarViewModel>(
        builder: (context, viewModel, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "More Like This",
                  style: Constants.theme.textTheme.titleLarge,),
                Expanded(
                  child:
                  ListView.builder(
                    itemCount: viewModel.similarMovieModel.results?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= viewModel.similarMovieModel.results!.length) {
                        // Return an empty SizedBox if the index is out of bounds
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: Constants.mediaQuery.height * 0.2,
                                    child: CachedNetworkImage(
                                      imageUrl: "https://image.tmdb.org/t/p/original/${viewModel
                                          .similarMovieModel.results?[index]
                                          .posterPath}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error, size: 60,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (tappedIndex == index) {
                                          tappedIndex =
                                          -1; // Unset tapped index if already tapped
                                        } else {
                                          tappedIndex =
                                              index; // Set tapped index
                                          var movieId =
                                              viewModel.similarMovieModel.results?[index].id;
                                          var existingMovie = movie.where(
                                              'id',
                                              isEqualTo: movieId);
                                          existingMovie
                                              .get()
                                              .then((snapshot) {
                                            if (snapshot.docs.isEmpty) {
                                              var newDoc = movie.doc(viewModel
                                                  .similarMovieModel.results?[index].id
                                                  .toString());
                                              newDoc.set(
                                                  viewModel.similarMovieModel.results?[index].toJson());
                                              // movie.add(viewModel
                                              //     .releases[index]
                                              //     .toJson());
                                            }
                                          });
                                        }
                                      });
                                    },
                                    child: Image.asset(
                                      tappedIndex == index
                                          ? "assets/images/bookmark_tap.png"
                                          : "assets/images/bookmark.png",
                                    ),
                                  ),
                                  //Image.asset("assets/images/bookmark.png")

                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.star, color: Color(0xffFFA90A),
                                    size: 20,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "${viewModel.similarMovieModel.results?[index]
                                        .voteAverage?.toStringAsFixed(1)}",
                                    style: Constants.theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  "${viewModel.similarMovieModel.results?[index]
                                      .title}",
                                  style: Constants.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${viewModel.similarMovieModel.results?[index]
                                    .releaseDate}",
                                style: Constants.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: Color(0xffB5B4B4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                      return SizedBox();
                    },
                  ),

                ),

              ]
          );
        }
      ),
    );
  }
}
