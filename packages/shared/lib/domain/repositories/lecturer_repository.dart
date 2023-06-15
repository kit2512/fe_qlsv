import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'base_repository.dart';
import 'package:shared/models/models.dart';
import 'package:shared/results/results.dart';
import 'package:shared/constants/constants.dart';

class LecturerRepository extends BaseRepository {
  Future<Either<Failure, List<LecturerModel>>> getLecturers({
    String? keyword,
    int? facultyId,
  }) async {
    try {
      final response = await restfulModule.get(
        Endpoints.lecturer,
        query: {}
          ..addAllIf(keyword != null, {"keyword": keyword})
          ..addAllIf(facultyId != null, {"faculty_id": facultyId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data
            .map((e) => LecturerModel.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } catch (e) {
      return Left(SystemFailure(
        errorCode: '500',
        message: e.toString(),
      ));
    }
  }

  Future<Either<Failure, LecturerModel>> getLecturerDetails(
      String lecturerId) async {
    try {
      final response = await restfulModule.get(
        Endpoints.lecturerDetails(lecturerId),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Right(LecturerModel.fromJson(json));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      final data = jsonDecode(e.response?.data ?? "{}");
      return Left(
        SystemFailure(
          errorCode: e.response?.statusCode.toString() ?? "500",
          message: data["msg"],
        ),
      );
    }
  }

  Future<Either<Failure, LecturerModel>> updateLecturer(
      LecturerModel lecturerModel) async {
    try {
      final response = await restfulModule.put(
        Endpoints.lecturer,
        data: lecturerModel.toJson(),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Right(LecturerModel.fromJson(json));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      final data = jsonDecode(e.response?.data ?? "{}");
      return Left(
        SystemFailure(
          errorCode: e.response?.statusCode.toString() ?? "500",
          message: data["msg"],
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteLecturer(String lecturerId) async {
    try {
      final response = await restfulModule.delete(
        Endpoints.lecturer,
        data: {"id": lecturerId},
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      final data = jsonDecode(e.response?.data ?? "{}");
      return Left(
        SystemFailure(
          errorCode: e.response?.statusCode.toString() ?? "500",
          message: data["msg"],
        ),
      );
    }
  }

  Future<Either<Failure, List<LecturerModel>>> getFacultyLecturers({required int id}) async {
    try {
      final response = await restfulModule.get(
        Endpoints.facultyLecturers(id),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data
            .map((e) => LecturerModel.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } catch (e) {
      return Left(SystemFailure(
        errorCode: '500',
        message: e.toString(),
      ));
    }
  }
}
