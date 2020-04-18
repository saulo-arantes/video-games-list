import 'dart:async';

import 'package:dio/dio.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';

Future<List<Map>> _indexGames(page) {
  final int pageSize = paginationSize;
  final String today = Dates.format(date: new DateTime.now());
  final String thirtyDaysPast = Dates.format(date: new DateTime.now().subtract(new Duration(days: 9)));
  final String url = "https://api.rawg.io/api/games?dates=$thirtyDaysPast,$today&platforms=18,1,7&page=$page&page_size=$pageSize";
  Response response;

  try {
      return Future.delayed(Duration(seconds: 1), () async {
      try {
        response = await Dio().get(url, options: dioOptionsRawg);
      } on DioError {
        return new List<Map>();
      } on DioErrorType {
        return new List<Map>();
      }

      return List<Map>.generate(response.data["results"].length, (int index) {
        return {
          "name": response.data["results"][index]["name"],
          "slug": response.data["results"][index]["slug"],
          "released": response.data["results"][index]["released"],
          "backgroundImage": response.data["results"][index]["background_image"],
          "clip": response.data["results"][index]["clip"],
          "website": response.data["results"][index]["website"],
          "rating": response.data["results"][index]["rating"],
          "parentPlatforms": response.data["results"][index]["parent_platforms"],
          "stores": response.data["results"][index]["stores"],
          "genres": response.data["results"][index]["genres"],
          "screenshots": response.data["results"][index]["short_screenshots"],
        };
      });
    });
  } on DioError {
    return Future.delayed(Duration(seconds: 1), () async {
      return new List<Map>();
    });
  } on DioErrorType {
    return Future.delayed(Duration(seconds: 1), () async {
      return new List<Map>();
    });
  }
}

Future<Map> getGame({String slug}) async {
  final String url = "https://api.rawg.io/api/games/$slug";
  final Response response = await Dio().get(url, options: dioOptionsRawg);

  return response.data;
}

class Game {
  final String name;
  final String slug;
  final String released;
  final String backgroundImage;
  final clip;
  final String website;
  final double rating;
  final parentPlatforms;
  final stores;
  final List genres;
  final List screenshots;

  Game({
    this.name,
    this.slug,
    this.released,
    this.backgroundImage,
    this.clip,
    this.website,
    this.rating,
    this.parentPlatforms,
    this.stores,
    this.genres,
    this.screenshots
  });

  factory Game.fromServerMap(data) {
    return Game(
      name: data["name"],
      slug: data["slug"],
      released: data["released"],
      backgroundImage: data["backgroundImage"],
      clip: data["clip"],
      website: data["website"],
      rating: data["rating"],
      parentPlatforms: data["parentPlatforms"],
      stores: data["stores"],
      genres: data["genres"],
      screenshots: data["screenshots"],
    );
  }
}

class Games {
  Stream<List<Game>> stream;
  bool hasMore;
  StreamController<List<Map>> _controller;
  bool _isLoading;
  List<Map> _data;

  Games() {
    _data = List<Map>();
    _controller = StreamController<List<Map>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map((List<Map> gamesData) {
      return gamesData.map((Map gameData) {
        return Game.fromServerMap(gameData);
      }).toList();
    });
    hasMore = true;

    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCacheData: true);
  }

  Future<void> loadMore({bool clearCacheData = false, int pagination = 1}) {
    if (clearCacheData) {
      _data = List<Map>();
      hasMore = true;
    }

    if (_isLoading || !hasMore) {
      return Future.value();
    }

    _isLoading = true;

    return _indexGames(pagination).then((gamesData) {
      _isLoading = false;
      _data.addAll(gamesData);
      hasMore = pagination <= 3 && gamesData.length >= paginationSize;
      _controller.add(_data);
    });
  }
}
