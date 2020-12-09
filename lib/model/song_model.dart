class Song {
  int id;
  String cover;
  String name;
  String artist;
  String album;
  String lyric;
  String source;

  Song({
    this.id,
    this.cover,
    this.name,
    this.artist,
    this.album,
    this.lyric,
    this.source,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        artist: json["artist"],
        album: json["album"],
        lyric: json["lyric"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "artist": artist,
        "album": album,
        "lyric": lyric,
        "source": source,
      };
}
