import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';
import 'package:hiveandapi_clean/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
  );
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerStudent(StudentEntity student) async {
    return await _authRepository.registerStudent(student);
  }

  Future<Either<Failure, bool>> loginStudent(
      String username, String password) async {
    return await _authRepository.loginStudent(username, password);
  }
}


