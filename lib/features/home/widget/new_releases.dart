import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/main.dart';
import '../../../core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/releases_view_model.dart';
import 'package:movie_app/models/ReleaseModel.dart';
import 'package:movie_app/core/config/routes/page_route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewReleases extends StatefulWidget {
  ReleaseFilms? result;

  NewReleases({super.key, this.result});

  @override
  State<NewReleases> createState() => _NewReleasesState();
}

class _NewReleasesState extends State<NewReleases> {
  var viewModel = ReleasesViewModel();
  bool tap = false;
  int tappedIndex = -1;
  CollectionReference movie =
      FirebaseFirestore.instance.collection(Constants.movieCollection);

  @override
  void initState() {
    super.initState();
    viewModel.fetchReleases();
  }

  @override
  Widget build(BuildContext context) {
    //ApiManager.fetchReleases();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ReleasesViewModel>(builder: (context, viewModel, child) {
        //if(snapshot.hasData) {
        //print(snapshot.data?.docs[0]["release date"]);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Color(0xff282A28)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Releases",
                          style: Constants.theme.textTheme.titleLarge,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.releases.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navigatekey.currentState!.pushNamed(
                                            PageRouteName.details,
                                            arguments:
                                                viewModel.releases[index]);
                                      },
                                      child: SizedBox(
                                        width: 100,
                                        height:
                                            Constants.mediaQuery.height * 0.2,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original/${viewModel.releases[index].posterPath}",
                                          // Set imageUrl to empty string if posterPath is null
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                viewModel.releases[index].id;
                                            var existingMovie = movie.where(
                                                'id',
                                                isEqualTo: movieId);
                                            existingMovie
                                                .get()
                                                .then((snapshot) {
                                              if (snapshot.docs.isEmpty) {
                                                var newDoc = movie.doc(viewModel
                                                    .releases[index].id
                                                    .toString());
                                                newDoc.set(
                                                    viewModel.releases[index].toJson());
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
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        );
      }
          // else {
          //   return CircularProgressIndicator();
          // }
          ),
    );
  }
}
