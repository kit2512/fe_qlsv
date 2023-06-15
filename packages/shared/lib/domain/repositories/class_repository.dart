import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared/constants/constants.dart';
import 'package:shared/domain/repositories/base_repository.dart';
import 'package:shared/models/models.dart';
import 'package:shared/results/failures.dart';

import '../../shared.dart';

class SubjectClassRepository extends BaseRepository {
  Future<Either<Failure, List<SubjectClassModel>>> getSubjectClasses({
    String? keyword,
    String? lecturerId,
  }) async {
    try {
      final response = await restfulModule.get(
        Endpoints.subjectClasses,
        query: {}
          ..addAllIf(keyword != null, {"keyword": keyword})
          ..addAllIf(lecturerId != null, {"lecturer_id": lecturerId}),
      );
      if (response.statusCode == 200) {
        final data = response.body as List<dynamic>;
        List<SubjectClassModel> results = [];
        for (final item in data) {
          results.add(SubjectClassModel.fromJson(item));
        }
        return Right(results);
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } catch (e) {
      rethrow;
      return Left(
        SystemFailure(
          errorCode: '500',
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, SubjectClassModel>> getSubjectClasDetails(
      String id) async {
    try {
      final response = await restfulModule.get(
        Endpoints.subjectClassDetails(id),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(SubjectClassModel.fromJson(data as Map<String, dynamic>));
      } else {
        return Left(SystemFailure(
          errorCode: response.statusCode.toString(),
          message: jsonDecode(response.body)['msg'],
        ));
      }
    } catch (e) {
      return Left(
        SystemFailure(
          errorCode: '500',
          message: e.toString(),
        ),
      );
    }
  }

}
