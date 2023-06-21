import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/course/data/data_source/course_remote_data.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';
import 'package:hiveandapi_clean/features/course/domain/repository/course_repository.dart';


final courseRemoteRepoProvider = Provider<ICourseRepository>((ref) {
  return CourseRemoteRepositoryImpl(
    courseRemoteDataSource: ref.read(courseRemoteDataSourceProvider),
  );
});

class CourseRemoteRepositoryImpl implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRemoteRepositoryImpl({
    required this.courseRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course)  {
    return  courseRemoteDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
   return courseRemoteDataSource.getAllCourse();
  }
}

