import 'dart:async';

import 'package:dio/dio.dart';

Future<List<Map>> _indexGames(page) {
  final int pageSize = 10;
  final String url = "https://api.rawg.io/api/games?ordering=-rating,-released&page=$page&page_size=$pageSize";
  print(url);

  return Future.delayed(Duration(seconds: 1), () async {
    final Response response = await Dio().get(url);

    return List<Map>.generate(pageSize, (int index) {
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
      };
    });
  });
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
      hasMore = pagination <= 3;
      _controller.add(_data);
    });
  }
}
