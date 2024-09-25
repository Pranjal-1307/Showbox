import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:showbox/common/utils.dart';
import 'package:showbox/models/search_model.dart';
import 'package:showbox/models/tv_series_model.dart';
import 'package:showbox/models/Upcoming_Movies.dart';
import 'package:http/http.dart' as http;

const baseUrl="https://api.themoviedb.org/3/";
var key="?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async{
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Upcoming Movies Failed To Load");
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async{
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Now Playing Movies Failed To Load");
  }


  Future<TvsSeriesModel> getTopRatedSeries() async{
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Success");
      return TvsSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Now Playing Top Rated TV Series Failed To Load");
  }

  Future<SearchModel> getSearchMovie(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";

    if (kDebugMode) {
      print("Search URL: $url");
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1OWQ0NmE2NGM5OWQzNjQwYTgxYzdiNTBiOGZiOTNmMCIsIm5iZiI6MTcyNzEwMDIwMy41Mzg0OTUsInN1YiI6IjY2YjBhZWNhNzQ0M2YyNzk3OWJkZDZlZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1lTrBapKQZ3egFJeybU_jWG_4P4xsq7YsRnIoLo9orY",
      },
    );

    if (response.statusCode == 200) {
      log("Success: Search Results Fetched");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load search results");
  }
}


