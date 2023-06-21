import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/config/constants/api_endpoint.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';


import '../../../../core/network/remote/http_service.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> uploadProfilePicture(File image) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture':
            await MultipartFile.fromFile(image.path, filename: fileName),
      });
      Response response =
          await dio.post(ApiEndpoints.uploadImage, data: formData);
      return Right(response.data['data']);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // Register Student

  Future<Either<Failure, String>> registerStudent({
    required String fname,
    required String lname,
    required String password,
    String? image,
    required String username,
    required String phone,
    required String batch,
    required List<String> courses,
  }) async {
    try {
      Response response = await dio.post(ApiEndpoints.register, data: {
        'fname': fname,
        'lname': lname,
        'password': password,
        'image': image ?? '',
        'username': username,
        'phone': phone,
        'batch': batch,
        'courses': courses,
      });
      return Right(response.data['data']);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // Login Student
  Future<Either<Failure, String>> loginStudent({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(ApiEndpoints.login, data: {
        'email': email,
        'password': password,
      });
      return Right(response.data['data']);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}