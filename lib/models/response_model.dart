class ResponseModel {
    int? code;
    String? status;
    String? copyright;
    String? attributionText;
    String? attributionHtml;
    String? etag;
    Data? data;

    ResponseModel({
        this.code,
        this.status,
        this.copyright,
        this.attributionText,
        this.attributionHtml,
        this.etag,
        this.data,
    });

    factory ResponseModel.fromMap(Map<String, dynamic> json) => ResponseModel(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data?.toMap(),
    };
}

class Data {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Result>? results;

  Data({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}


class Result {
    int? id;
    String? name;
    String? description;
    String? modified;
    Thumbnail? thumbnail;
    String? resourceUri;
    Comics? comics;
    Comics? series;
    Stories? stories;
    Comics? events;
    List<Url>? urls;
    String? heroId;


    Result({
        this.id,
        this.name,
        this.description,
        this.modified,
        this.thumbnail,
        this.resourceUri,
        this.comics,
        this.series,
        this.stories,
        this.events,
        this.urls,
        this.heroId,

    });


    factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        modified: json["modified"],
        thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromMap(json["thumbnail"]),
        resourceUri: json["resourceURI"],
        comics: json["comics"] == null ? null : Comics.fromMap(json["comics"]),
        series: json["series"] == null ? null : Comics.fromMap(json["series"]),
        stories: json["stories"] == null ? null : Stories.fromMap(json["stories"]),
        events: json["events"] == null ? null : Comics.fromMap(json["events"]),
        urls: json["urls"] == null ? null : List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "modified": modified,
        "thumbnail": thumbnail?.toMap(),
        "resourceURI": resourceUri,
        "comics": comics?.toMap(),
        "series": series?.toMap(),
        "stories": stories?.toMap(),
        "events": events?.toMap(),
        "urls": urls == null ? null : List<dynamic>.from(urls!.map((x) => x.toMap())),
    };

    factory Result.fromJson(Map<String, dynamic> json) {
  return Result(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    modified: json["modified"],
    thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
    resourceUri: json["resourceURI"],
    comics: json["comics"] == null ? null : Comics.fromJson(json["comics"]),
    series: json["series"] == null ? null : Comics.fromJson(json["series"]),
    stories: json["stories"] == null ? null : Stories.fromJson(json["stories"]),
    events: json["events"] == null ? null : Comics.fromJson(json["events"]),
    urls: json["urls"] == null ? null : List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
  );
}

}

class Comics {
    int? available;
    String? collectionUri;
    List<ComicsItem>? items;
    int? returned;

    Comics({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    factory Comics.fromMap(Map<String, dynamic> json) => Comics(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null ? null : List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromMap(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toMap())),
        "returned": returned,
    };

    factory Comics.fromJson(Map<String, dynamic> json) {
    return Comics(
      available: json["available"],
      collectionUri: json["collectionURI"],
      items: json["items"] == null ? null : List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromJson(x))),
      returned: json["returned"],
    );
  }

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "returned": returned,
  };
}

class ComicsItem {
    String? resourceUri;
    String? name;

    ComicsItem({
        this.resourceUri,
        this.name,
    });

    factory ComicsItem.fromMap(Map<String, dynamic> json) => ComicsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
    };
    factory ComicsItem.fromJson(Map<String, dynamic> json) {
    return ComicsItem(
      resourceUri: json["resourceURI"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
  };
}

class Stories {
    int? available;
    String? collectionUri;
    List<StoriesItem>? items;
    int? returned;

    Stories({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    factory Stories.fromMap(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null ? null : List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromMap(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toMap())),
        "returned": returned,
    };

    factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
      available: json["available"],
      collectionUri: json["collectionURI"],
      items: json["items"] == null ? null : List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
      returned: json["returned"],
    );
  }

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "returned": returned,
  };
}

class StoriesItem {
    String? resourceUri;
    String? name;
    ItemType? type;

    StoriesItem({
        this.resourceUri,
        this.name,
        this.type,
    });

    factory StoriesItem.fromMap(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: itemTypeValues.map[json["type"]],
    );

    Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": itemTypeValues.reverse[type],
    };

    factory StoriesItem.fromJson(Map<String, dynamic> json) {
    return StoriesItem(
      resourceUri: json["resourceURI"],
      name: json["name"],
      type: itemTypeValues.map[json["type"]],
    );
  }

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
    "type": itemTypeValues.reverse[type],
  };
}

enum ItemType { COVER, INTERIOR_STORY, EMPTY }

final itemTypeValues = EnumValues({
    "cover": ItemType.COVER,
    "": ItemType.EMPTY,
    "interiorStory": ItemType.INTERIOR_STORY
});

class Thumbnail {
    String? path;
    Extension? extension;

    Thumbnail({
        this.path,
        this.extension,
    });

    factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: extensionValues.map[json["extension"]],
    );

    Map<String, dynamic> toMap() => {
        "path": path,
        "extension": extensionValues.reverse[extension],
    };

    factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      path: json["path"],
      extension: extensionValues.map[json["extension"]],
    );
  }

  Map<String, dynamic> toJson() => {
    "path": path,
    "extension": extensionValues.reverse[extension],
  };
}

enum Extension { JPG, GIF }

final extensionValues = EnumValues({
    "gif": Extension.GIF,
    "jpg": Extension.JPG
});

class Url {
    UrlType? type;
    String? url;

    Url({
        this.type,
        this.url,
    });

    factory Url.fromMap(Map<String, dynamic> json) => Url(
        type: urlTypeValues.map[json["type"]],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "type": urlTypeValues.reverse[type],
        "url": url,
    };
    factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: urlTypeValues.map[json["type"]],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": urlTypeValues.reverse[type],
    "url": url,
  };
}

enum UrlType { DETAIL, WIKI, COMICLINK }

final urlTypeValues = EnumValues({
    "comiclink": UrlType.COMICLINK,
    "detail": UrlType.DETAIL,
    "wiki": UrlType.WIKI
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
