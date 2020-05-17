class Top {
    List<Datum> data;

    Top({
        this.data,
    });

    factory Top.fromJson(Map<String, dynamic> json) => Top(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String cover;
    String name;
    Artist artist;
    Album album;
    String lyric;
    String source;

    Datum({
        this.id,
        this.cover,
        this.name,
        this.artist,
        this.album,
        this.lyric,
        this.source,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        artist: Artist.fromJson(json["artist"]),
        album: Album.fromJson(json["album"]),
        lyric: json["lyric"],
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "artist": artist.toJson(),
        "album": album.toJson(),
        "lyric": lyric,
        "source": source,
    };
}

class Album {
    String albumName;
    String albumDetail;

    Album({
        this.albumName,
        this.albumDetail,
    });

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumName: json["album_name"],
        albumDetail: json["album_detail"],
    );

    Map<String, dynamic> toJson() => {
        "album_name": albumName,
        "album_detail": albumDetail,
    };
}

class Artist {
    String artistName;
    String artistDetail;

    Artist({
        this.artistName,
        this.artistDetail,
    });

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        artistName: json["artist_name"],
        artistDetail: json["artist_detail"],
    );

    Map<String, dynamic> toJson() => {
        "artist_name": artistName,
        "artist_detail": artistDetail,
    };
}
