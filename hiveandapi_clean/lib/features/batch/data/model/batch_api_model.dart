import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/batch_entity.dart';

part 'batch_api_model.g.dart';

final batchApiModelProvider = Provider ((ref)=>
BatchApiModel.empty(),

);

@JsonSerializable()
class BatchApiModel {
  @JsonKey(name: '_id')
  final String? batchId;
  final String? batchName;

  BatchApiModel({this.batchId, this.batchName});

  //data comming from json

  factory BatchApiModel.fromJson(Map<String, dynamic> json) =>
      _$BatchApiModelFromJson(json);

//data sendign to json
  Map<String, dynamic> toJson() => _$BatchApiModelToJson(this);

  // Create empty HiveBatchModel
  BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  // Convert to BatchEntity from BatchHiveModel
  BatchEntity toBatchEntity() {
    return BatchEntity(
      batchId: batchId ?? '',
      batchName: batchName ?? '',
    );
  }

  // Convert to List<BatchEntity> from List<BatchHiveModel>
  List<BatchEntity> toBatchEntities(List<BatchApiModel> batches) {
    return batches.map((batch) => batch.toBatchEntity()).toList();
  }

  @override
  String toString() {
    return 'BatchApiModel{batchId: $batchId, batchName: $batchName}';
  }
}