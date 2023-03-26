import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freegames/services/api.dart';

import '../models/game_moel.dart';

class Games with ChangeNotifier {
  bool isFailed = false;
  List<GameModel> gameList = [];
  String? platform;
  bool isLoading = false;
  final Api _api = Api();
  getGames(String? platformQuery) async {
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

    notifyListeners();
  }
}
