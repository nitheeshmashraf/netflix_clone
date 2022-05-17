import 'package:netflix_clone/core/strings.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = kBaseUrl + "trending/all/day?api_key=" + apiKey;
  static const search = kBaseUrl +
      "search/movie?language=en-US&page=1&include_adult=false&api_key=" +
      apiKey;

  static const hotAndNewMovie = kBaseUrl + "discover/movie?api_key=" + apiKey;
  static const hotAndNewTV = kBaseUrl + "discover/tv?api_key=" + apiKey;
}
