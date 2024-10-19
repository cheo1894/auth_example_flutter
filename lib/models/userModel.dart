import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String registerMethod;
  String email;
  String phoneNumber;
  String firstName;
  String lastname;
  String country;
  String fcmToken;
  String createdAt;
  String updatedAt;
  String age;

  UserModel({
    required this.id,
    required this.registerMethod,
    this.email = '',
    this.phoneNumber = '',
    this.firstName = '',
    this.lastname = '',
    this.country = '',
    this.fcmToken = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.age = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        registerMethod: json["registerMethod"],
        email: json["email"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        firstName: json["firstName"] ?? '',
        lastname: json["lastname"] ?? '',
        country: json["country"] ?? '',
        fcmToken: json["fcmToken"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        age: json["Age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registerMethod": registerMethod,
        "email": email,
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastname": lastname,
        "country": country,
        "fcmToken": fcmToken,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "Age": age,
      };
}
