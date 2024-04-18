import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../viewModel/recomended_view_model.dart';

class RecomendedFilms extends StatefulWidget {
  const RecomendedFilms({super.key});

  @override
  State<RecomendedFilms> createState() => _RecomendedFilmsState();
}

class _RecomendedFilmsState extends State<RecomendedFilms> {
  var viewModel = RecomendedViewModel();
  CollectionReference movie =
  FirebaseFirestore.instance.collection(Constants.movieCollection);
  int tappedIndex = -1;
  @override
  void initState() {
    viewModel.fetchTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child:
          Consumer<RecomendedViewModel>(builder: (context, viewModel, child) {
        return Container(
          decoration: const BoxDecoration(color: Color(0xff282A28)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Recommended",
                style: Constants.theme.textTheme.titleLarge,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.trendList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
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
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original/${viewModel.trendList[index].posterPath}", // Set imageUrl to empty string if posterPath is null
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error,
                                            size: 60, color: Colors.grey),
                                  ),
                                ),
                                // Image.asset("assets/images/bookmark.png")
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
                                            viewModel.trendList[index].id;
                                        var existingMovie = movie.where(
                                            'id',
                                            isEqualTo: movieId);
                                        existingMovie
                                            .get()
                                            .then((snapshot) {
                                          if (snapshot.docs.isEmpty) {
                                            var newDoc = movie.doc(viewModel
                                                .trendList[index].id
                                                .toString());
                                            newDoc.set(
                                                viewModel.trendList[index].toJson());
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
                                const Icon(
                                  Icons.star,
                                  color: Color(0xffFFA90A),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${viewModel.trendList[index].voteAverage?.toStringAsFixed(1)}",
                                  style: Constants.theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "${viewModel.trendList[index].title}",
                                style: Constants.theme.textTheme.bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${viewModel.trendList[index].releaseDate}",
                              style: Constants.theme.textTheme.bodyMedium
                                  ?.copyWith(color: const Color(0xffB5B4B4)),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
