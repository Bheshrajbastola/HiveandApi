import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final StudentEntity? studentEntity;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.studentEntity,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      studentEntity: null,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    StudentEntity? studentEntity,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      studentEntity: studentEntity ?? this.studentEntity,
    );
  }

  @override
  String toString() =>
      'StudentAuthState(isLoading: $isLoading, error: $error , imageName: $imageName)';
}