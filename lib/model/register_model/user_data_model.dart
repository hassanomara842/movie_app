import '../../domain/entities/user_entity.dart';

/// message : "User registered successfully"
/// data : {"email":"amr2@gmail.com","password":"$2b$10$hashedPasswordExample","name":"amr mustafa","phone":"+201141209334","avaterId":1,"_id":"65f1c8e92b1e5c0012abc123","createdAt":"2026-02-21T12:00:00.000Z","updatedAt":"2026-02-21T12:00:00.000Z","__v":0}

class UserDataModel {
  UserDataModel({
    this.message,
    this.data,
  });

  UserDataModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// email : "amr2@gmail.com"
/// password : "$2b$10$hashedPasswordExample"
/// name : "amr mustafa"
/// phone : "+201141209334"
/// avaterId : 1
/// _id : "65f1c8e92b1e5c0012abc123"
/// createdAt : "2026-02-21T12:00:00.000Z"
/// updatedAt : "2026-02-21T12:00:00.000Z"
/// __v : 0

class Data {
  Data({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id ?? "",
      name: name ?? "",
      email: email ?? "",
      phone: phone ?? "",
      avaterId: avaterId ?? 0,
    );
  }
}
