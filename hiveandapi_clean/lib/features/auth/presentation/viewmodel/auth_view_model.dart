// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hiveandapi_clean/features/auth/domain/use_case/auth_usecase.dart';
// import 'package:hiveandapi_clean/features/auth/presentation/state/auth_state.dart';

// final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(ref.read(authUseCaseProvider)),
// );

// class AuthViewModel extends StateNotifier<AuthState> {
//   final AuthUseCase authUseCase;

//   AuthViewModel(this.authUseCase) : super(AuthState.initial());

//   Future<void> uploadProfilePicture(File image) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.uploadProfilePicture(image);

//     data.fold(
//       (l) => state = state.copyWith(isLoading: false, error: l.error),
//       (r) => state = state.copyWith(isLoading: false, error: null),
//     );
//   }

//   Future<void> registerStudent({
//     required String fname,
//     required String lname,
//     required String password,
//     String? image,
//     required String username,
//     required String phone,
//     required String batch,
//     required List<String> courses,
//   }) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.registerStudent(
//       fname: fname,
//       lname: lname,
//       password: password,
//       image: image,
//       username: username,
//       phone: phone,
//       batch: batch,
//       courses: courses,
//     );

//     data.fold(
//       (l) => state = state.copyWith(isLoading: false, error: l.error),
//       (r) => state = state.copyWith(isLoading: false, error: null),
//     );
//   }

//   Future<void> loginStudent({
//     required String username,
//     required String password,
//   }) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.loginStudent(
//       username: username,
//       password: password,
//     );

//     data.fold(
//       (l) => state = state.copyWith(isLoading: false, error: l.error),
//       (r) => state = state.copyWith(isLoading: false, error: null),
//     );
//   }
// }



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/config/router/app_route.dart';
import 'package:hiveandapi_clean/core/common/snackbar/my_snackbar.dart';
import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';
import 'package:hiveandapi_clean/features/auth/domain/use_case/auth_usecase.dart';
import 'package:hiveandapi_clean/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState(isLoading: false));

  Future<void> registerStudent(StudentEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerStudent(student);
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loginStudent(
    BuildContext context,
    String username, 
    String password) 
    async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.loginStudent(username, password);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,context: context,color:Colors.red);
      },
    
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.popAndPushNamed(context,AppRoute.homeRoute);
      },
    );

  }




  Future<void> uploadImage(File file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }
}