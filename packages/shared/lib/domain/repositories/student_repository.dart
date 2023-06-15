import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared/constants/endpoints.dart';
import 'package:shared/domain/repositories/base_repository.dart';
import 'package:shared/models/models.dart';
import 'package:shared/results/results.dart';

import '../../models/student_model.dart';

class ListStudentModel {
  final int? total;
  final int? size;
  final int? page;
  final List<StudentModel>? items;

  ListStudentModel({
    this.total,
    this.size,
    this.page,
    this.items,
  });
}

class StudentRepository extends BaseRepository {
  Future<Either<Failure, ListStudentModel>> getStudent({
    String? keyword,
    String? facultyId,
    String? majorId,
    String? yearOfAdmission,
  }) async {
    try {
      final res = await restfulModule.get(Endpoints.allStudents,
          query: {}
            ..addAllIf(
              keyword != null,
              {
                "keyword": keyword,
              },
            )
            ..addAllIf(
              facultyId != null,
              {
                "facultyId": facultyId,
              },
            )
            ..addAllIf(
              majorId != null,
              {
                "majorId": majorId,
              },
            )
            ..addAllIf(
              yearOfAdmission != null,
              {
                "yearOfAdmission": yearOfAdmission,
              },
            ));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List;
        return Right(ListStudentModel(
            items: data.map((e) => StudentModel.fromJson(e)).toList()));
      } else {
        return Left(
          SystemFailure(
            errorCode: res.statusCode.toString(),
            message: res.body["msg"],
          ),
        );
      }
    } catch (e) {
      return Left(
        SystemFailure(
          errorCode: "500",
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> createStudent({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
    required String citizenId,
    required String nation,
    required String religion,
    required String nationality,
    required String studentCode,
    required String classId,
    required UserRole roleName,
    required UserGender gender,
    required int majorId,
    required int yearOfAdmission,
    required int graduationYear,
    required String password,
  }) async {
    final data = {};
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
    data['gender'] = gender.name;
    data['role_name'] = roleName.name;
    data['nationality'] = nationality;
    data['password'] = password;

    final res = await restfulModule.post(Endpoints.student, jsonEncode(data));
    if (res.statusCode == 200) {
      return const Right(true);
    } else {
      final body = jsonDecode(res.body);
      return Left(SystemFailure(message: body["msg"], errorCode: res.statusCode.toString()));
    }

  }

  Future<Either<Failure, bool>> deleteStudent(String studentCode) async {
    try {
      final response = await restfulModule.delete(Endpoints.student, data: jsonEncode({"student_code": studentCode}));
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        final body = jsonDecode(response.body);
        return Left(SystemFailure(message: body["msg"], errorCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(SystemFailure(message: e.message, errorCode: e.response?.statusCode.toString()));
    }
  }

  Future<Either<Failure, List<StudentModel>>> getFacultyStudents({required int id}) async {
    try {
      final response = await restfulModule.get(Endpoints.facultyStudents(id));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data.map((e) => StudentModel.fromJson(e)).toList());
      } else {
        final body = jsonDecode(response.body);
        return Left(SystemFailure(message: body["msg"], errorCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(SystemFailure(message: e.message, errorCode: e.response?.statusCode.toString()));
    }
  }
}
