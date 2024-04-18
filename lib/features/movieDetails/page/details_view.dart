import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/features/movieDetails/page/similar_movie.dart';
import 'package:movie_app/features/movieDetails/widget/geners_movie.dart';
import 'package:movie_app/features/search/viewModel/search_cubit/cubit.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/movieDetails/viewModel/details_view_model.dart';

import '../../../models/DetailsModel.dart';
import '../../../models/ReleaseModel.dart';
import '../../../models/SearchModel.dart';

class MovieDetails extends StatefulWidget {
  final ReleaseFilms? releaseFilm;
  const MovieDetails({
    Key? key,
     this.releaseFilm,
  }) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var viewModel = DetailsViewModel();
  @override
  void initState() {
    final id = widget.releaseFilm?.id;
    viewModel.fetchDetails(id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<DetailsViewModel>(builder: (context, viewModel, child) {
        return viewModel.isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/${viewModel.detailsModel.posterPath}"),
                            fit: BoxFit.fill,
                            onError: (exception, stackTrace) {
                              exception.toString();
                            },
                          ),
                        ),
                        child: const Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${viewModel.detailsModel.originalTitle}",
                            style: Constants.theme.textTheme.titleLarge,
                          ),
                          Text("${viewModel.detailsModel.releaseDate}",
                              style: Constants.theme.textTheme.bodySmall
                                  ?.copyWith(color: Color(0xffB5B4B4))),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: 230,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.3),
                                            BlendMode.darken),
                                        image: NetworkImage(
                                          "https://image.tmdb.org/t/p/original/${viewModel.detailsModel.posterPath}",
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "${viewModel.detailsModel.originalTitle}",
                                            style: Constants
                                                .theme.textTheme.bodySmall
                                                ?.copyWith(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white),
                                          ),
                                        ),
                                        Image.asset(
                                            "assets/images/bookmark.png"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Wrap(
                                          spacing: 6,
                                          runSpacing: 6,
                                          children: [
                                            for (var genre in viewModel
                                                    .detailsModel.genres ??
                                                [])
                                              GenersMovie(
                                                  movie: genre.name ?? ""),
                                          ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(
                                          "${viewModel.detailsModel.overview}",
                                          maxLines: 4,
                                          style: Constants
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.2,
                                                  wordSpacing: 2.0,
                                                  height: 1.5,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 30,
                                            color: Color(0xffFFA90A),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              "${viewModel.detailsModel.voteAverage?.toStringAsFixed(1)}",
                                              style: Constants
                                                  .theme.textTheme.titleLarge),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            flex: 2,
                            child: SimilarMovie(
                              detailsFilms: viewModel.detailsModel,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }
}
