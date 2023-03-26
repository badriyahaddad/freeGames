import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:freegames/services/api.dart';
import '../models/details_model.dart';
import '../models/game_model.dart';

class Games with ChangeNotifier {
  DetailsModel? detailsModel;
  bool isFailed = false;
  List<GameModel> gameList = [];
  String? platform;
  bool isLoading = false;
  final Api _api = Api();
  getGames(String? platformQuery) async {
    isLoading = true;
    notifyListeners();

    var response = await _api.get(
        platformQuery == null
            ? '/api/games'
            : '/api/games?platform=$platformQuery',
        {});

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      setGames(rawData);
    }
  }

  setGames(jsonData) {
    gameList.clear();

    for (var i in jsonData) {
      gameList.add(GameModel.fromJson(i));
    }
    isLoading = false;

    notifyListeners();
  }

  //details
  getDetailsGames(int? id) async {
    var response = await _api.get('/api/game?id=$id', {});
    isLoading = true;

    notifyListeners();
    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      setDeatilsGames(rawData);
    }
  }

  setDeatilsGames(jsonData) {
    detailsModel = DetailsModel.fromJson(jsonData);
    isLoading = false;

    notifyListeners();
  }
}
