import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final deleteObjectItemProvider = Provider<DeleteObjectItemUseCase>(
  (ref) => DeleteObjectItemUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class DeleteObjectItemUseCase
    implements ParamsUseCase<Future<void>, DeleteObjectItemUseCaseParams> {
  final ObjectRepository objectRepository;

  DeleteObjectItemUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.deleteObjectItem(
      tableName: params.objectType,
      objectId: params.objectId,
    );
  }
}

class DeleteObjectItemUseCaseParams {
  final String objectType;
  final String objectId;

  DeleteObjectItemUseCaseParams({
    required this.objectType,
    required this.objectId,
  });
}
