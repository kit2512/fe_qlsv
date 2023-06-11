import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared/constants/constants.dart';
import 'package:shared/domain/repositories/base_repository.dart';
import 'package:shared/models/models.dart';
import 'package:shared/results/failures.dart';

class SubjectClassRepository extends BaseRepository {
  Future<Either<Failure, List<SubjectClassModel>>> getSubjectClasses({
    String? keyword,
    String? lecturerId,
  }) async {
    try {
      final response = await restfulModule.get(
        Endpoints.lecturer,
        query: {}
          ..addAllIf(keyword != null, {"keyword": keyword})
          ..addAllIf(lecturerId != null, {"lecturer_id": lecturerId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return Right(data
            .map((e) => SubjectClassModel.fromJson(e as Map<String, dynamic>))
            .toList());
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
