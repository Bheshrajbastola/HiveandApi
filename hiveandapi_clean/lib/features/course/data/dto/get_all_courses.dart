import 'package:hiveandapi_clean/features/course/data/model/course_api_model.dart';
import 'package:json_annotation/json_annotation.dart';



part 'get_all_courses.g.dart';

@JsonSerializable()
class GetAllCoursesDTO {
  final bool success;
  final int count;
  final List<CourseApiModel> data;
  GetAllCoursesDTO({
    required this.success,
    required this.count,
    required this.data,
  });
  Map<String, dynamic> toJson() => _$GetAllCoursesDTOToJson(this);

  factory GetAllCoursesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCoursesDTOFromJson(json);
}