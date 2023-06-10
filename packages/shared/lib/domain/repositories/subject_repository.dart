import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared/constants/endpoints.dart';
import 'package:shared/domain/repositories/base_repository.dart';
import 'package:shared/models/models.dart';
import 'package:shared/results/results.dart';

class SubjectRepository extends BaseRepository {
  Future<Either<Failure, SubjectModel>> createSubjcet({
    required String subjectName,
    required int credits,
    required String id,
  }) async {
    try {
      final response = await restfulModule.post(Endpoints.subject, {
        "id": id,
        "subject_name": subjectName,
        "credits": credits,
      });
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Right(SubjectModel.fromJson(json as Map<String, dynamic>));
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

  Future<Either<Failure, List<SubjectModel>>> getSubjectList({
    String? keyword,
    int? majorId,
    int? facultyId,
  }) async {
    try {
      final response = await restfulModule.get(
        Endpoints.subject,
        query: {}
          ..addAllIf(keyword != null, {"keyword": keyword})
          ..addAllIf(majorId != null, {"major_id": majorId})
          ..addAllIf(facultyId != null, {"faculty_id": facultyId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(
          data
              .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
              .toList(
                growable: false,
              ),
        );
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

  Future<Either<Failure, bool>> deleteSubject(String subjectId) async {
    try {
      final response = await restfulModule.delete(
        Endpoints.subject,
        data: {"id": subjectId},
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

  Future<Either<Failure, SubjectModel>> getSubject(String subjectId) async {
    try {
      final response = await restfulModule.get(
        Endpoints.subject,
        query: {"id": id},
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Right(SubjectModel.fromJson(json));
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

  Future<Either<Failure, SubjectModel>> updateSubject(SubjectModel subjectModel) async {
    try {
      final response = await restfulModule.put(
        Endpoints.subject,
        data: subjectModel.toJson(),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Right(SubjectModel.fromJson(json));
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
}
