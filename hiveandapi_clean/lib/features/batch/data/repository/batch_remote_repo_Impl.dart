import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/features/batch/data/data_source/batch_remote_data_source.dart';
import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hiveandapi_clean/features/batch/domain/repository/batch_repository.dart';


final batchRemoteRepoProvider = Provider<IBatchRepository>((ref){
  return BatchRemoteRepositoryImpl
  (batchRemoteDataSource: ref.read(batchRemoteDataSourceProvider),
  );

  
});


class BatchRemoteRepositoryImpl implements IBatchRepository {
   final BatchRemoteDataSource batchRemoteDataSource;


   BatchRemoteRepositoryImpl ({
    required this.batchRemoteDataSource,
});

  @override
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) {
    return batchRemoteDataSource.addBatch(batch);
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    return batchRemoteDataSource.getAllBatches();
  }


}