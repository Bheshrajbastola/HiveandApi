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














// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hiveandapi_clean/config/constants/api_endpoint.dart';
// import 'package:hiveandapi_clean/core/failure/failure.dart';

// import 'package:hiveandapi_clean/core/network/remote/http_service.dart';
// import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';

// final authRemoteDataSourceProvider = Provider(
//   (ref) => AuthRemoteDataSource(
//     dio: ref.read(httpServiceProvider),
//   ),
// );

// class AuthRemoteDataSource {
//   final Dio dio;

//   AuthRemoteDataSource({required this.dio});

//   Future<Either<Failure, bool>> registerStudent(StudentEntity student) async {
//     try {
//       Response response = await dio.post(
//         ApiEndpoints.register,
//         data: {
//           "fname": student.fname,
//           "lname": student.lname,
//           "image": student.image,
//           "username": student.username,
//           "password": student.password,
//           "batch": student.batch!.batchId,
//           // "course": ["6489a5908dbc6d39719ec19c", "6489a5968dbc6d39719ec19e"]
//           "course": student.courses.map((e) => e.courseId).toList(),
//         },
//       );
//       if (response.statusCode == 200) {
//         return const Right(true);
//       } else {
//         return Left(
//           Failure(
//             error: response.data["message"],
//             statusCode: response.statusCode.toString(),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       return Left(
//         Failure(
//           error: e.error.toString(),
//           statusCode: e.response?.statusCode.toString() ?? '0',
//         ),
//       );
//     }
//   }

//   // Upload image using multipart
//   Future<Either<Failure, String>> uploadProfilePicture(
//     File image,
//   ) async {
//     try {
//       String fileName = image.path.split('/').last;
//       FormData formData = FormData.fromMap(
//         {
//           'profilePicture': await MultipartFile.fromFile(
//             image.path,
//             filename: fileName,
//           ),
//         },
//       );

//       Response response = await dio.post(
//         ApiEndpoints.uploadImage,
//         data: formData,
//       );

//       return Right(response.data["data"]);
//     } on DioException catch (e) {
//       return Left(
//         Failure(
//           error: e.error.toString(),
//           statusCode: e.response?.statusCode.toString() ?? '0',
//         ),
//       );
//     }
//   }
// }