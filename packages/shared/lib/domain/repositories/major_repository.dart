import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared/constants/endpoints.dart';
import 'package:shared/results/results.dart';
import 'package:shared/models/models.dart';
import 'base_repository.dart';

class MajorRepository extends BaseRepository {
  Future<Either<Failure, List<MajorModel>>> getMajors() async {
    final response = await restfulModule.get(Endpoints.major);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return Right(data
          .map((e) => MajorModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else if (response.statusCode == 404){
      return const Right([]);
    }
      else {
      return Left(SystemFailure(
        errorCode: response.statusCode.toString(),
        message: jsonDecode(response.body)['msg'],
      ));
    }
  }

  Future<Either<Failure, List<MajorModel>>> getFacultyMajor({required int facultyId}) async {
    try {
      final response = await restfulModule.get(Endpoints.facultyMajors(facultyId));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data
            .map((e) => MajorModel.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ),);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Right([]);
      } else {
        return Left(SystemFailure(
          errorCode: e.response?.statusCode.toString() ?? '500',
          message: e.response?.data['msg'] ?? e.toString(),
        ));
      }
    }
  }

  Future<Either<Failure, MajorModel>> createMajor({required String name, required int facultyId}) async {
    try {
      final response = await restfulModule.post(Endpoints.major, {
        "major_name": name,
        "faculty_id": facultyId,
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(MajorModel.fromJson(data as Map<String, dynamic>));
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

  Future<Either<Failure, MajorModel>> deleteMajor(int id) async {
    try {
      final response = await restfulModule.delete(Endpoints.major, data: {"id": id});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(MajorModel.fromJson(data as Map<String, dynamic>));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } on DioException catch (e) {
      final data = jsonDecode(e.response?.data ?? "{}");
      return Left(SystemFailure(
        errorCode: e.response?.statusCode.toString() ?? '500',
        message: data['msg'] ?? e.toString(),
      ));
    }
  }

  Future<Either<Failure, List<MajorModel>>> getFacultyMajors({required int id}) async {
    try {
      final response = await restfulModule.get(Endpoints.facultyMajors(id));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data
            .map((e) => MajorModel.fromJson(e as Map<String, dynamic>))
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
