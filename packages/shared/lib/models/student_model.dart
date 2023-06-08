import 'user_model.dart';

class StudentModel extends UserModel {
  String studentCode;
  String classId;
  int majorId;
  int yearOfAdmission;
  int graduationYear;

  StudentModel({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required this.studentCode,
    required this.classId,
    required this.majorId,
    required this.yearOfAdmission,
    required this.graduationYear,
    required super.phoneNumber,
    required super.address,
    required super.dateOfBirth,
    required super.citizenId,
    required super.nation,
    required super.religion,
    required super.gender,
    required super.roleName,
    required super.nationality,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        uid: json['uid'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        studentCode: json['student_code'],
        classId: json['class_id'],
        majorId: json['major_id'],
        yearOfAdmission: json['year_of_admission'],
        graduationYear: json['graduation_year'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        dateOfBirth: json['date_of_birth'],
        citizenId: json['citizen_id'],
        nation: json['nation'],
        religion: json['religion'],
        gender: json['gender'],
        roleName: json['role_name'],
        nationality: json['nationality'],
      );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['student_code'] = studentCode;
    data['class_id'] = classId;
    data['major_id'] = majorId;
    data['year_of_admission'] = yearOfAdmission;
    data['graduation_year'] = graduationYear;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['date_of_birth'] = dateOfBirth;
    data['citizen_id'] = citizenId;
    data['nation'] = nation;
    data['religion'] = religion;
    data['gender'] = gender;
    data['role_name'] = roleName;
    data['nationality'] = nationality;
    return data;
  }
}
