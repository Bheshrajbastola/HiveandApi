import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/course/data/data_source/course_local_data_source.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';
import 'package:hiveandapi_clean/features/course/domain/repository/course_repository.dart';


final courseLocalRepoProvider = Provider<ICourseRepository>((ref) {
  return CourseLocalRepositoryImpl(
    courseLocalDataSource: ref.read(courseLocalDataSourceProvider),
  );
});

class CourseLocalRepositoryImpl implements ICourseRepository {
  final CourseLocalDataSource courseLocalDataSource;

  CourseLocalRepositoryImpl({
    required this.courseLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseLocalDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseLocalDataSource.getAllCourses();
  }
}