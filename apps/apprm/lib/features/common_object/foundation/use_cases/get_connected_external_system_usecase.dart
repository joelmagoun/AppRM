import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getConnectedExternalSystemProvider =
    Provider<GetConnectedExternalSystemUseCase>(
  (ref) => GetConnectedExternalSystemUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetConnectedExternalSystemUseCase
    implements
        ParamsUseCase<Future<List<Map<String, dynamic>>>,
            GetConnectedExternalSystemUseCaseParams> {
  final ObjectRepository objectRepository;

  GetConnectedExternalSystemUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getConnectedExternalSystem(
      tableName: params.objectType,
      objectId: params.objectId,
    );
  }
}

class GetConnectedExternalSystemUseCaseParams {
  final String objectType;
  final String objectId;

  GetConnectedExternalSystemUseCaseParams({
    required this.objectType,
    required this.objectId,
  });
}
