import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/config/constants/api_endpoint.dart';
import 'package:hiveandapi_clean/core/failure/failure.dart';
import 'package:hiveandapi_clean/core/network/remote/http_service.dart';
import 'package:hiveandapi_clean/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:hiveandapi_clean/features/batch/data/model/batch_api_model.dart';
import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';

final batchRemoteDataSourceProvider = Provider.autoDispose
(((ref)=>
BatchRemoteDataSource(
  dio: ref.read(httpServiceProvider),
  batchApiModel: ref.read(batchApiModelProvider),

)


));

class BatchRemoteDataSource{
  final Dio dio;
  final BatchApiModel batchApiModel;

  BatchRemoteDataSource({
    required this.dio,
    required this.batchApiModel,
  });



  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async{

    try{
      var response = await dio.post(
        ApiEndpoints.createBatch,
        data: {
          "batchName":batch.batchName,
        },
      );
      //check for status code
      if(response.statusCode == 200){
        return Right(true);

      }else{
        return Left(Failure(error: response.statusMessage.toString()));
      }

    }on DioException catch(e){
      return Left(Failure(error: e.message.toString()));
    }





  }
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try{
      var response = await dio.get(ApiEndpoints.getAllBatch);
    
    //check for the satus code
    if(response.statusCode == 200){
      GetAllBatchDTO getAllBatchDTO = GetAllBatchDTO.fromJson(response.data);  
      return  Right(batchApiModel.toBatchEntities(getAllBatchDTO.data));
    }else{
      return left(Failure(error:response.statusMessage.toString()));
    }


    }on DioException catch(e){
      return Left(Failure(error: e.message.toString()));
    }
  }
}

  



