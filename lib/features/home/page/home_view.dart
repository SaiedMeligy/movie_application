
import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_network.dart';
import 'package:movie_app/features/browse/page/browse_view.dart';
import 'package:movie_app/features/home/page/films_view.dart';
import 'package:movie_app/features/home/widget/background_poster.dart';
import 'package:movie_app/features/home/widget/new_releases.dart';
import 'package:movie_app/features/search/page/search_view.dart';
import 'package:movie_app/features/watchList/page/watchList_view.dart';
import 'package:movie_app/models/PosterModel.dart';

class HomeView extends StatefulWidget {
   HomeView({super.key,});

  @override
  State<HomeView> createState() => _HomeViewState();
}
int currentIndex = 0;
List<Widget> Screens = [
   FilmsView(),
   SearchView(),
  const BrowseView(),
  const WatchListView(),
];

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    //ApiManager.fetchPosters();
    return Scaffold(
      body:Screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.5,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/images/Home icon.png')),
              label: "Home"),
          BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/images/search-2.png')),
              label: "SEARCH"),
          BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/images/Icon material-movie.png')),
              label: "BROWSE"),
          BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/images/Icon ionic-md-bookmarks.png')),
              label: "WATCHLIST"),
        ],
      ),
    );
  }
}
