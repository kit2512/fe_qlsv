import 'package:easy_localization/easy_localization.dart';

enum UserGender {
  male, female,
}

enum UserRole {
  admin, student, lecturer,
}

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  DateTime dateOfBirth;
  String citizenId;
  String nation;
  String religion;
  String nationality;
  UserGender gender;
  UserRole roleName;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.citizenId,
    required this.nation,
    required this.religion,
    required this.nationality,
    required this.gender,
    required this.roleName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      address: json["address"],
      dateOfBirth: DateFormat("yyyy-MM-DD").parse(json["date_of_birth"].replaceAll("/", "-")),
      citizenId: json["citizen_id"],
      nation: json["nation"],
      religion: json["religion"],
      nationality: json["nationality"],
      gender: UserGender.values.byName(json["gender"]),
      roleName: UserRole.values.byName(json["role_name"])
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "date_of_birth": DateFormat("yyyy-MM-DD").format(dateOfBirth),
        "citizen_id": citizenId,
        "nation": nation,
        "religion": religion,
        "nationality": nationality,
        "gender": gender.name,
        "role_name": roleName.name,
      };
}
