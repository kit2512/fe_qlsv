import 'package:dartz/dartz.dart';
import 'package:shared/constants/endpoints.dart';
import 'package:shared/shared.dart';

import '../../results/results.dart';

class UserRepository {
  final RestfulModule _restfulModule;

  UserRepository({
    required RestfulModule restfulModule,
  }) : _restfulModule = restfulModule;

  Future<Either<Failure, UserModel>> getCurrentUserInfo() async {
    final res = await _restfulModule.get(Endpoints.users);
    if (res.statusCode == 200) {
      return Right(UserModel.fromJson(res.body));
    } else {
      return Left(
        SystemFailure(
          message: res.statusMessage,
        ),
      );
    }
  }
}
