class User {
    Success success;

    User({
        this.success,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        success: Success.fromJson(json["success"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success.toJson(),
    };
}

class Success {
    String token;
    Details details;

    Success({
        this.token,
        this.details,
    });

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        token: json["token"],
        details: Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "details": details.toJson(),
    };
}

class Details {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    String vip;
    DateTime createdAt;
    DateTime updatedAt;

    Details({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.vip,
        this.createdAt,
        this.updatedAt,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        vip: json["vip"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "vip": vip,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
