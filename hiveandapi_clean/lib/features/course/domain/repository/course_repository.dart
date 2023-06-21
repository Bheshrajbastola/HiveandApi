import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/course/data/repository/course_local_repo.dart';
import 'package:hiveandapi_clean/features/course/data/repository/course_remote_repository.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider<ICourseRepository>((ref)
 {

 //return ref.read(courseLocalRepoProvider);

// for the internet

return ref.read(courseRemoteRepoProvider);

});


abstract class ICourseRepository {
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
}