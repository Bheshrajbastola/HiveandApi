import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/features/auth/domain/use_case/auth_usecase.dart';
import 'package:hiveandapi_clean/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(authUseCaseProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;

  AuthViewModel(this.authUseCase) : super(AuthState.initial());

  Future<void> uploadProfilePicture(File image) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfilePicture(image);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> registerStudent({
    required String fname,
    required String lname,
    required String password,
    String? image,
    required String username,
    required String phone,
    required String batch,
    required List<String> courses,
  }) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerStudent(
      fname: fname,
      lname: lname,
      password: password,
      image: image,
      username: username,
      phone: phone,
      batch: batch,
      courses: courses,
    );

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> loginStudent({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginStudent(
      email: email,
      password: password,
    );

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }
}