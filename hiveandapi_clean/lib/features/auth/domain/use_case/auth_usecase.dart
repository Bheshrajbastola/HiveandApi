import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider<AuthUseCase>(
  (ref) => AuthUseCase(
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class AuthUseCase {
  final IAuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<Either<Failure, String>> uploadProfilePicture(File image) {
    return authRepository.uploadProfilePicture(image);
  }

  Future<Either<Failure, String>> registerStudent({
    required String fname,
    required String lname,
    required String password,
    String? image,
    required String username,
    required String phone,
    required String batch,
    required List<String> courses,
  }) {
    return authRepository.registerStudent(
      fname: fname,
      lname: lname,
      password: password,
      username: username,
      image: image,
      phone: phone,
      batch: batch,
      courses: courses,
    );
  }

  Future<Either<Failure, String>> loginStudent({
    required String email,
    required String password,
  }) {
    return authRepository.loginStudent(
      username: email,
      password: password,
    );
  }
}