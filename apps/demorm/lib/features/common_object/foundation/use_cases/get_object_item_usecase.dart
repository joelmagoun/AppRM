import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getObjectItemProvider = Provider<GetObjectItemUseCase>(
  (ref) => GetObjectItemUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetObjectItemUseCase
    implements
        ParamsUseCase<Future<Map<String, dynamic>>,
            GetObjectItemUseCaseParams> {
  final ObjectRepository objectRepository;

  GetObjectItemUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getObjectItem(
      tableName: params.objectType,
      objectId: params.objectId,
    );
  }
}

class GetObjectItemUseCaseParams {
  final String objectType;
  final String objectId;

  GetObjectItemUseCaseParams({
    required this.objectType,
    required this.objectId,
  });
}
