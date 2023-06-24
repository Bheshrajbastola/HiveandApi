// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hiveandapi_clean/core/failure/failure.dart';
// import 'package:hiveandapi_clean/features/auth/data/data_source/auth_remote_datasource.dart';
// import 'package:hiveandapi_clean/features/auth/data/repository/auth_remote_repository.dart';


// final authRepositoryProvider = Provider<IAuthRepository>(
//   (ref) => AuthRemoteRepositiry(
//     authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
//   ),
// );

// abstract class IAuthRepository {
//   Future<Either<Failure, String>> uploadProfilePicture(File image);
//   Future<Either<Failure, String>> registerStudent({
//     required String fname,
//     required String lname,
//     required String password,
//     String? image,
//     required String username,
//     required String phone,
//     required String batch,
//     required List<String> courses,
//   });
  
//   Future<Either<Failure, String>> loginStudent({
//     required String username,
//     required String password,
//   });
// }


import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/auth/data/repository/auth_remote_repository.dart';
import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerStudent(StudentEntity student);
  Future<Either<Failure, bool>> loginStudent(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}