import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:hiveandapi_clean/features/auth/domain/repository/auth_repository.dart';


class AuthRemoteRepositiry implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepositiry({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File image) async {
    return await authRemoteDataSource.uploadProfilePicture(image);
  }

  @override
  Future<Either<Failure, String>> loginStudent(
      {required String username, required String password}) async {
    return await authRemoteDataSource.loginStudent(
        email: username, password: password);
  }

  @override
  Future<Either<Failure, String>> registerStudent(
      {required String fname,
      required String lname,
      required String password,
      String? image,
      required String username,
      required String phone,
      required String batch,
      required List<String> courses}) {
    return authRemoteDataSource.registerStudent(
        fname: fname,
        lname: lname,
        password: password,
        username: username,
        phone: phone,
        batch: batch,
        courses: courses);
  }
}