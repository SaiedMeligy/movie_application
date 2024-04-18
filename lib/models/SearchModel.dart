/// page : 1
/// results : [{"adult":false,"backdrop_path":"/1XDDXPXGiI8id7MrUxK36ke7gkX.jpg","genre_ids":[28,12,16,35,10751],"id":1011985,"original_language":"en","original_title":"Kung Fu Panda 4","overview":"Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.","popularity":5768.648,"poster_path":"/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg","release_date":"2024-03-02","title":"Kung Fu Panda 4","video":false,"vote_average":7.003,"vote_count":311},{"adult":false,"backdrop_path":null,"genre_ids":[16,10751],"id":283332,"original_language":"en","original_title":"Kung Fu Panda - The Midnight Stranger Vol.4","overview":"","popularity":21.695,"poster_path":"/3RzNHWFRi9cirAWkt07vHFf1F8o.jpg","release_date":"2014-06-01","title":"Kung Fu Panda - The Midnight Stranger Vol.4","video":true,"vote_average":5.4,"vote_count":8},{"adult":false,"backdrop_path":"/e5O854T0ejt1SuFs7WPEhrTrnLh.jpg","genre_ids":[10751,16,35],"id":381547,"original_language":"en","original_title":"Kung Fu Panda: Legends of Awesomeness (Good Croc, Bad Croc)","overview":"Po gets suckered by Fung to break into a castle","popularity":18.189,"poster_path":"/hTCMyh1PJdzide0X5GYouXds3vq.jpg","release_date":"2011-11-10","title":"Kung Fu Panda: Legends of Awesomeness (Good Croc, Bad Croc)","video":true,"vote_average":6.3,"vote_count":10}]
/// total_pages : 1
/// total_results : 3

class SearchModel {
  SearchModel({
      this.page, 
      this.results, 
      this.totalPages, 
      this.totalResults,});

  SearchModel.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(SearchList.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? page;
  List<SearchList>? results;
  int? totalPages;
  int? totalResults;

}

class SearchList {
  SearchList({
      this.adult, 
      this.backdropPath, 
      this.genreIds, 
      this.id, 
      this.originalLanguage, 
      this.originalTitle, 
      this.overview, 
      this.popularity, 
      this.posterPath, 
      this.releaseDate, 
      this.title, 
      this.video, 
      this.voteAverage, 
      this.voteCount,});

  SearchList.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;


}