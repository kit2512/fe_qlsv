import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared/constants/endpoints.dart';
import 'package:shared/results/failures.dart';

import 'package:shared/models/models.dart';
import 'base_repository.dart';

class FacultyRepository extends BaseRepository {
  Future<Either<Failure, List<FacultyModel>>> getFacultiesList(
      {String? keyword}) async {
    try {
      final response = await restfulModule.get(Endpoints.faculty, query: {
        'keyword': keyword,
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data
            .map((e) => FacultyModel.fromJson(e as Map<String, dynamic>))
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

  Future<Either<Failure, FacultyModel>> createFaculty(
      {required String name}) async {
    try {
      final response = await restfulModule.post(Endpoints.faculty, {
        "faculty_name": name,
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(FacultyModel.fromJson(data as Map<String, dynamic>));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      return Left(SystemFailure(
        errorCode: e.response?.statusCode.toString() ?? '500',
        message: e.response?.data['msg'] ?? e.toString(),
      ));
    }
  }

  Future<Either<Failure, bool>> deleteFaculty({required int id}) async {
    try {
      final response =
          await restfulModule.delete(Endpoints.faculty, data: {"id": id});
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      return Left(
        SystemFailure(
          errorCode: e.response?.statusCode.toString() ?? '500',
          message: e.response?.data['msg'] ?? e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, FacultyModel>> getFaculty({required int id}) async {
    try {
      final response = await restfulModule.get(Endpoints.facultyDetails(id));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(FacultyModel.fromJson(data as Map<String, dynamic>));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      return Left(SystemFailure(
        errorCode: e.response?.statusCode.toString() ?? '500',
        message: e.response?.data['msg'] ?? e.toString(),
      ));
    }
  }

  Future<Either<Failure, FacultyModel>>updateFaculty(FacultyModel faculty) async {
    try {
      final response = await restfulModule.put(Endpoints.faculty, data: faculty.toJson());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(FacultyModel.fromJson(data as Map<String, dynamic>));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      return Left(SystemFailure(
        errorCode: e.response?.statusCode.toString() ?? '500',
        message: e.response?.data['msg'] ?? e.toString(),
      ));
    }
  }


}
