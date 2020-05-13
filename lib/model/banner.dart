// Banner bannerFromJson(String str) => Banner.fromJson(json.decode(str));

// String bannerToJson(Banner data) => json.encode(data.toJson());

class Banner {
    Data data;

    Banner({
        this.data,
    });

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    String path;

    Data({
        this.path,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
    };
}
