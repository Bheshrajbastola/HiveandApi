import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/features/batch/data/data_source/batch_local_data_source.dart';
import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';
import 'package:hiveandapi_clean/features/batch/domain/repository/batch_repository.dart';

final batchLocalRepoProvider = Provider<IBatchRepository>((ref) {
  return BatchLocalRepositoryImpl(
    batchLocalDataSource: ref.read(batchLocalDataSourceProvider),
  );
});

class BatchLocalRepositoryImpl implements IBatchRepository {
  final BatchLocalDataSource batchLocalDataSource;

  BatchLocalRepositoryImpl({
    required this.batchLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) {
    return batchLocalDataSource.addBatch(batch);
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    return batchLocalDataSource.getAllBatches();
  }
}
