import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:meeja/core/models/book_model.dart';
import 'package:meeja/core/models/music_model.dart';

import '../models/movie_model.dart';

////
class ApiServices {
  Future<MovieModel?> getmovie({title = "titanic"}) async {
    try {
      var url = Uri.parse("https://imdb-api.com/API/Search/k_elcgooer/$title");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // List<MovieModel> result = movieModelFromJson(response.body);
        MovieModel result = MovieModel.fromJson(jsonDecode(response.body));
        print(response.body);
        return result;
      }
    } catch (e) {
      print("error===============>${e.toString()}");
    }
  }
  ////////get music///
  ///
  ///

  Future<MusicModel?> getMusic({title}) async {
    try {
      var url = Uri.parse(
          "https://deezerdevs-deezer.p.rapidapi.com/search?q=${title}");
      var response = await http.get(
        url,
        headers: {
          "X-RapidAPI-Key": "5ff49903c9msha606f4a9802a266p10404fjsn553854fd4214"
        },
      );
      if (response.statusCode == 200) {
        // List<MovieModel> result = movieModelFromJson(response.body);
        MusicModel result = MusicModel.fromJson(jsonDecode(response.body));
        print(response.body);
        print(
            "music++++++api function================================================>");
        return result;
      }
    } catch (e) {
      print("error===============>${e.toString()}");
    }
  }

//////
  ///getbook
  ///

  Future<BookModel?> getbook({title}) async {
    try {
      var url = Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=${title}&Key=AIzaSyCOaitwEH8K2IgojTHDLWD23txwNrmaU64");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("================================");

        BookModel result = BookModel.fromJson(jsonDecode(response.body));

        log(response.body);
        return result;
      }
    } catch (e) {
      print("error===============>${e.toString()}");
    }
  }
}


//musicapi key =0fc16a8f5bmsha26df269d4e4d87p13f755jsn4b73518bfac3

// bookApiKey=AIzaSyCOaitwEH8K2IgojTHDLWD23txwNrmaU64
    

