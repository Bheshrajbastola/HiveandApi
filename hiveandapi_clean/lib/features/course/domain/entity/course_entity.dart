class CourseEntity {
  final String? courseId;
  final String courseName;

  CourseEntity({
    this.courseId,
    required this.courseName,
  });

  factory CourseEntity.fromJson(Map<String, dynamic> json) {
    return CourseEntity(
      courseId: json['courseId'],
      courseName: json['courseName'],
    );
  }
}
