import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/batch/data/repository/batch_remote_repo_Impl.dart';
import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';

final batchRepositoryProvider = Provider<IBatchRepository>((ref) {
  // Return Local repository implementation
  // For internet connectivity we will check later
 
 //for remote
 // return ref.read(batchLocalRepoProvider);


// for the internet
return ref.read(batchRemoteRepoProvider);

});

abstract class IBatchRepository {
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();
  Future<Either<Failure, bool>> addBatch(BatchEntity batch);
}
