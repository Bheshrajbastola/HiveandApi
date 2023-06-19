import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/course/data/data_source/course_local_data_source.dart';
import 'package:hiveandapi_clean/features/course/data/repository/course_repository.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider<ICourseRepository>(
  (ref) => LocalCourseRepositoryImpl(
    courseLocalDataSource: ref.read(courseLocalDataSourceProvider),
  ),
);

abstract class ICourseRepository {
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
}
