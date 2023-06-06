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
  String role;

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
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        dateOfBirth: json['date_of_birth'],
        citizenId: json['citizen_id'],
        nation: json['nation'],
        religion: json['religion'],
        nationality: json['nationality'],
        gender: json['gender'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['date_of_birth'] = dateOfBirth;
    data['citizen_id'] = citizenId;
    data['nation'] = nation;
    data['religion'] = religion;
    data['nationality'] = nationality;
    data['gender'] = gender;
    data['role'] = role;
    return data;
  }
}
