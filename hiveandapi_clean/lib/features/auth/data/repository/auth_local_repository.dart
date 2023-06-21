// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hiveandapi_clean/core/failure/failure.dart';
// import 'package:hiveandapi_clean/features/auth/data/data_source/auth_local_data_source.dart';
// import 'package:hiveandapi_clean/features/auth/domain/entity/student_entity.dart';
// import 'package:hiveandapi_clean/features/auth/domain/repository/auth_repository.dart';

// final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
//   return AuthLocalRepository(
//     ref.read(authLocalDataSourceProvider),
//   );
// });

// class AuthLocalRepository implements IAuthRepository {
//   final AuthLocalDataSource _authLocalDataSource;

//   AuthLocalRepository(this._authLocalDataSource);

//   @override
//   Future<Either<Failure, bool>> loginStudent(String username, String password) {
//     return _authLocalDataSource.loginStudent(username, password);
//   }

//   @override
//   Future<Either<Failure, bool>> registerStudent(StudentEntity student) {
//     return _authLocalDataSource.registerStudent(student);
//   }
// }
