import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';


class StudentEntity {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final BatchEntity? batch;
  final List<CourseEntity> courses;
  final String phone;
  final String username;
  final String password;

  StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.batch,
    this.image,
    required this.courses,
    required this.phone,
    required this.username,
    required this.password,
  });
}