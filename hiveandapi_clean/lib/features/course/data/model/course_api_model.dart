import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_api_model.g.dart';

final courseApiModelProvider = Provider<CourseApiModel>(
  (ref) => CourseApiModel.empty(),
);

@JsonSerializable()
class CourseApiModel {
  @JsonKey(name: "_id")
  final String courseID;
  final String courseName;

  CourseApiModel({
    required this.courseID,
    required this.courseName,
  });

  CourseApiModel.empty()
      : courseID = '',
        courseName = '';

  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  // Convert API Object to Entity
  CourseEntity toEntity() => CourseEntity(
        courseName: courseName,
        courseId: courseID,
      );

  // Convert Entity to API Object
  CourseApiModel fromEntity(CourseEntity entity) => CourseApiModel(
        courseID: entity.courseId ?? '',
        courseName: entity.courseName,
      );

  // Convert API List to Entity List
  List<CourseEntity> toEntityList(List<CourseApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}