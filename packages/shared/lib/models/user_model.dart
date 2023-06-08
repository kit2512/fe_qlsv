class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  String dateOfBirth;
  String citizenId;
  String nation;
  String religion;
  String nationality;
  String gender;
  String roleName;

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
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      address: json["address"],
      dateOfBirth: json["dateOfBirth"],
      citizenId: json["citizenId"],
      nation: json["nation"],
      religion: json["religion"],
      nationality: json["nationality"],
      gender: json["gender"],
      roleName: json["roleName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "dateOfBirth": dateOfBirth,
        "citizenId": citizenId,
        "nation": nation,
        "religion": religion,
        "nationality": nationality,
        "gender": gender,
        "roleName": roleName,
      };
}
