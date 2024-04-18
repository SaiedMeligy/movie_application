import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/models/PosterModel.dart';
import 'package:movie_app/models/RecomendedModel.dart';
import 'package:movie_app/models/ReleaseModel.dart';
import 'package:movie_app/models/SearchModel.dart';
import 'package:movie_app/models/SimilarMovieModel.dart';

import '../../models/CategoryFilm.dart';
import '../../models/DetailsModel.dart';
import '../../models/RelatedMovie.dart';

class ApiManager{
  static Future<List<Results>> fetchPosters()async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=${Constants.api_key}");
    final response=await http.get(url);
    if(response.statusCode==200){
      //print(response.body);
      var data = jsonDecode(response.body);
      List posterList =data["results"];
      PosterModel posterModel = PosterModel.fromJson(data);
      return posterModel.results??[];
    }else
      {
        throw Exception("Failed to load posters");
      }
  }
  static Future<List<ReleaseFilms>> fetchReleases()async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.api_key}");
    final response=await http.get(url);
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      List releaseList =data["results"];
      ReleaseModel releaseModel = ReleaseModel.fromJson(data);
      return releaseModel.results??[];
    }else
      {
        throw Exception("Failed to load posters");
      }
  }
  static Future<List<RecommendFilms>> fetchTrending()async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.api_key}");
    final response = await http.get(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      List recomendedList = data["results"];
      RecomendedModel recomendedModel = RecomendedModel.fromJson(data);
      return recomendedModel.results??[];
    }
    else {
      throw Exception("Failed to load trending");
    }
  }
  static Future<DetailsModel> fetchDetailsMovie(int id)async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/movie/$id?api_key=${Constants.api_key}");
    final response = await http.get(url);
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      return DetailsModel.fromJson(data);
    }
    else {
      throw Exception("Failed to load trending");
    }
  }
  static Future<SimilarMovieModel> fetchSimilarMovie(int id)async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/movie/$id/similar?api_key=${Constants.api_key}");
    var response= await http.get(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return  SimilarMovieModel.fromJson(data);
    }
    else {
      throw Exception("Failed to load SimilarMovie");
    }
  }
  static Future<List<SearchList>> fetchMovies(String query)async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=${Constants.api_key}&query=$query");
    final response = await http.get(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      List searchList =data["results"];
      SearchModel searchModel = SearchModel.fromJson(data);
      return searchModel.results??[];
    }
    else {
      throw Exception("Failed to load Movies");
    }
  }
  static Future<List<Categories>> fetchCategory()async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.api_key}");
    final response =await http.get(url);
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      //print(response.body);
      List categories= data["genres"];
      CategoryFilm categoryFilms = CategoryFilm.fromJson(data);
      return categoryFilms.genres??[];
    }
    else {
      throw Exception("Failed to load Movies");
    }
  }
  static Future<List<Related>> fetchRelatedMovie(int withGenres)async{
    Uri url=Uri.parse("https://api.themoviedb.org/3/discover/movie?api_key=${Constants.api_key}&with_genres=$withGenres");

    final response =await http.get(url);
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      print(response.body);
      List related= data["results"];
      RelatedMovie relatedMovie = RelatedMovie.fromJson(data);
      return relatedMovie.results??[] ;
    }
    else {
      throw Exception("Failed to load Movies");
    }

  }
}