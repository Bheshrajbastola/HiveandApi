// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hiveandapi_clean/core/failure/failure.dart';
// import 'package:hiveandapi_clean/features/auth/domain/repository/auth_repository.dart';

// final authUseCaseProvider = Provider<AuthUseCase>(
//   (ref) => AuthUseCase(
//     authRepository: ref.read(authRepositoryProvider),
//   ),
// );

// class AuthUseCase {
//   final IAuthRepository authRepository;

//   AuthUseCase({required this.authRepository});

//   Future<Either<Failure, String>> uploadProfilePicture(File image) {
//     return authRepository.uploadProfilePicture(image);
//   }

//   Future<Either<Failure, String>> registerStudent({
//     required String fname,
//     required String lname,
//     required String password,
//     String? image,
//     required String username,
//     required String phone,
//     required String batch,
//     required List<String> courses,
//   }) {
//     return authRepository.registerStudent(
//       fname: fname,
//       lname: lname,
//       password: password,
//       username: username,
//       image: image,
//       phone: phone,
//       batch: batch,
//       courses: courses,
//     );
//   }

//   Future<Either<Failure, String>> loginStudent({
//     required String email,
//     required String password,
//   }) {
//     return authRepository.loginStudent(
//       username: email,
//       password: password,
//     );
//   }
// }



import 'dart:io';

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

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _authRepository.uploadProfilePicture(file);
  }
}