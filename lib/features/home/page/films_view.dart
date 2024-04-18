

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/config/routes/page_route_name.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/home/viewModel/releases_view_model.dart';
import 'package:movie_app/features/home/widget/background_poster.dart';
import 'package:movie_app/features/home/widget/new_releases.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/RecomendedModel.dart';
import 'package:provider/provider.dart';

import '../viewModel/films_view_model.dart';
import '../widget/recomended_Films.dart';

class FilmsView extends StatefulWidget {
  const FilmsView({super.key});

  @override
  State<FilmsView> createState() => _FilmsViewState();
}

class _FilmsViewState extends State<FilmsView> {
  bool tap = false;
  var viewModlel=FilmsViewModel();
  var releaseViewModel = ReleasesViewModel();

  @override
  void initState() {
    super.initState();
    viewModlel.fetchPosters();
  }
  Widget build(BuildContext context) {
    CollectionReference movie = FirebaseFirestore.instance.collection(Constants.movieCollection);

    return ChangeNotifierProvider(
      create: (context) => viewModlel,
      child: Consumer<FilmsViewModel>(
        builder: (context, releaseViewModel, child) {
          return Column(
            children: [
              Expanded(
                flex: 4,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      //floating: true,
                      //toolbarHeight: 40,
                      expandedHeight: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background:BackgroundPoster(poster:
                            viewModlel.results
                        ),
                      ),
                    ),
                  ],

                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                flex: 3,
                child:
                GestureDetector(
                    child: NewReleases(),
              ),
          ),
              Divider(thickness:4 ,
              color: Constants.theme.primaryColor,),
              const Expanded(flex:3,child: RecomendedFilms()),
              Divider(thickness:4 ,
                color: Constants.theme.primaryColor,),


          ]);

        }
      ),
    );
  }
}
