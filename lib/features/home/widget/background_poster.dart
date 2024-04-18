
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/models/PosterModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BackgroundPoster extends StatelessWidget {
  List<Results> poster;
   BackgroundPoster({super.key,required this.poster});

  Widget build(BuildContext context) {
    return
      CarouselSlider(
      options: CarouselOptions(
          height: Constants.mediaQuery.height,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(seconds: 2),
        //enlargeCenterPage: true,
        viewportFraction: 1,

        aspectRatio: 16 / 9,
      ),
      items: poster.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: (){},
              child:GestureDetector(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Constants.theme.primaryColor,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.height/4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                          //   image: NetworkImage("https://image.tmdb.org/t/p/original/${i.posterPath}" ),
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                            children:[
                              CachedNetworkImage(
                                imageUrl:
                                "https://image.tmdb.org/t/p/original/${i.posterPath}", // Set imageUrl to empty string if posterPath is null
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
                              Icon(Icons.play_circle_fill_outlined,color: Colors.white,size: 50,)]),
                        ),
                              Positioned(
                  bottom: 80,
                    left: 20,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 180,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // image: DecorationImage(
                          //   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                          //   image: NetworkImage("https://image.tmdb.org/t/p/original/${i.posterPath}", ),
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                              "https://image.tmdb.org/t/p/original/${i.posterPath}", // Set imageUrl to empty string if posterPath is null
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
                            Container(
                              alignment:Alignment.topLeft,
                              child: Text(
                                "${i.originalTitle}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal ,
                                ),
                              ),
                            ),
                            Image.asset("assets/images/bookmark.png"),
                          ],
                        ),

                      ),
                    ],
                  ),
                              ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160,bottom: 80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${i.originalTitle}",
                              style: Constants.theme.textTheme.titleLarge
                            ),
                            Text(
                              "${i.releaseDate}",
                              style: Constants.theme.textTheme.bodySmall?.copyWith(
                                color: Color(0xffB5B4B4)
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
