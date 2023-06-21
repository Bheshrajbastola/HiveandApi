import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/core/network/remote/http_service.dart';
import 'package:hiveandapi_clean/features/course/data/dto/get_all_courses.dart';
import 'package:hiveandapi_clean/features/course/data/model/course_api_model.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';

import '../../../../config/constants/api_endpoint.dart';


final courseRemoteDataSourceProvider = Provider((ref) => CourseRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      courseApiModel: ref.read(courseApiModelProvider),
    ));

class CourseRemoteDataSource {
  final Dio dio;
  final CourseApiModel courseApiModel;
  CourseRemoteDataSource({
    required this.dio,
    required this.courseApiModel,
  });

  Future<Either<Failure, List<CourseEntity>>> getAllCourse() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCourse);
      if (response.statusCode == 200) {
        GetAllCoursesDTO coursesDTO = GetAllCoursesDTO.fromJson(response.data);
        return Right(courseApiModel.toEntityList(coursesDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> addCourse(CourseEntity batch) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.fromEntity(batch).toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}