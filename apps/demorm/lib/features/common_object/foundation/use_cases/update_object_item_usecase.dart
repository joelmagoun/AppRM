import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final updateObjectItemProvider = Provider<UpdateObjectItemUseCase>(
  (ref) => UpdateObjectItemUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class UpdateObjectItemUseCase
    implements ParamsUseCase<Future<void>, UpdateObjectItemUseCaseParams> {
  final ObjectRepository objectRepository;

  UpdateObjectItemUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.updateObjectItem(
      tableName: params.objectType,
      objectId: params.objectId,
      data: params.data,
    );
  }
}

class UpdateObjectItemUseCaseParams {
  final String objectType;
  final String objectId;
  final Map<String, dynamic> data;

  UpdateObjectItemUseCaseParams({
    required this.objectType,
    required this.objectId,
    required this.data,
  });
}
