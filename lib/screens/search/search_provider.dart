import 'package:flutter/cupertino.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/core/models/book_model.dart';
import 'package:meeja/core/models/movie_model.dart';
import 'package:meeja/core/models/music_model.dart';

import '../../core/enums/view_state.dart';
import '../../core/services/api_services.dart';

class SearchProvider extends BaseViewModal {
  ApiServices _apiServices = ApiServices();
  BookModel? bookModel;
  MovieModel? movieModel;
  MusicModel? musicModel;
  String? dropdownValue = 'All';
  List<Results>? searchMovie;
  List<Items>? searchBook;
  List<Data>? searchMusic;
  bool isSearch = true;
  SearchProvider() {
    // getData();
    //getBookData();
    //getMusicData();
  }

  getDropdown(String? newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }

  searchAll(value, BuildContext context) async {
    isSearch = false;
    notifyListeners();

    if (dropdownValue == 'All') {
      await getBookData(query: value);
      await getMusicData(query: value);
      await getData(query: value);
    }
    if (dropdownValue == 'Book') {
      getBookData(query: value);
    }
    if (dropdownValue == 'Movie') {
      getData(query: value);
    }
    if (dropdownValue == 'Music') {
      getMusicData(query: value);
    }

    notifyListeners();
  }

  getData({required String query}) async {
    setState(ViewState.busy);
    searchMovie = null;
    notifyListeners();
    movieModel = await _apiServices.getmovie(title: query);
    // Future.delayed(const Duration(seconds: 1))
    //     .then((value) => notifyListeners());

    searchMovie = movieModel!.results;
    notifyListeners();

    print("=====================>${movieModel}");
    setState(ViewState.idle);
  }

  getBookData({required String query}) async {
    setState(ViewState.busy);
    searchBook = null;
    notifyListeners();
    bookModel = await _apiServices.getbook(title: query);
    print("=====================>${bookModel}");

    searchBook = bookModel!.items;

    setState(ViewState.idle);
    notifyListeners();
  }

  getMusicData({required String query}) async {
    setState(ViewState.busy);
    searchMusic = null;
    notifyListeners();
    musicModel = await _apiServices.getMusic(title: query);

    print("=====================>${musicModel}");
    searchMusic = musicModel!.data;

    setState(ViewState.idle);
    notifyListeners();
  }
}
