import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/auth/data/repository/auth_local_repository.dart';
import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authLocalRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerStudent(StudentEntity student);
  Future<Either<Failure, bool>> loginStudent(String username, String password);
}


