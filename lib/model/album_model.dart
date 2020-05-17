// To parse this JSON data, do
//
//     final album = albumFromJson(jsonString);

import 'dart:convert';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
    List<Datum> data;

    Album({
        this.data,
    });

    factory Album.fromJson(Map<String, dynamic> json) => Album(
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
    String about;
    DatumArtist artist;
    bool condition;
    List<Song> songs;
    String detail;

    Datum({
        this.id,
        this.cover,
        this.name,
        this.about,
        this.artist,
        this.condition,
        this.songs,
        this.detail,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        about: json["about"],
        artist: DatumArtist.fromJson(json["artist"]),
        condition: json["condition"],
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "about": about,
        "artist": artist.toJson(),
        "condition": condition,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
        "detail": detail,
    };
}

class DatumArtist {
    String name;
    String detail;

    DatumArtist({
        this.name,
        this.detail,
    });

    factory DatumArtist.fromJson(Map<String, dynamic> json) => DatumArtist(
        name: json["name"],
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "detail": detail,
    };
}

class Song {
    int id;
    String cover;
    String name;
    SongArtist artist;
    AlbumClass album;
    String lyric;
    String source;
    String detail;

    Song({
        this.id,
        this.cover,
        this.name,
        this.artist,
        this.album,
        this.lyric,
        this.source,
        this.detail,
    });

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        artist: SongArtist.fromJson(json["artist"]),
        album: AlbumClass.fromJson(json["album"]),
        lyric: json["lyric"],
        source: json["source"],
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "artist": artist.toJson(),
        "album": album.toJson(),
        "lyric": lyric,
        "source": source,
        "detail": detail,
    };
}

class AlbumClass {
    String albumName;
    String albumDetail;

    AlbumClass({
        this.albumName,
        this.albumDetail,
    });

    factory AlbumClass.fromJson(Map<String, dynamic> json) => AlbumClass(
        albumName: json["album_name"],
        albumDetail: json["album_detail"],
    );

    Map<String, dynamic> toJson() => {
        "album_name": albumName,
        "album_detail": albumDetail,
    };
}

class SongArtist {
    String artistName;
    String artistDetail;

    SongArtist({
        this.artistName,
        this.artistDetail,
    });

    factory SongArtist.fromJson(Map<String, dynamic> json) => SongArtist(
        artistName: json["artist_name"],
        artistDetail: json["artist_detail"],
    );

    Map<String, dynamic> toJson() => {
        "artist_name": artistName,
        "artist_detail": artistDetail,
    };
}
