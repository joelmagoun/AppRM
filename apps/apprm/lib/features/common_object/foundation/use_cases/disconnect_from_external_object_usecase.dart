import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final disconnectFromExternalObjectProvider =
    Provider<DisconnectFromExternalObjectUseCase>(
  (ref) => DisconnectFromExternalObjectUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class DisconnectFromExternalObjectUseCase
    implements
        ParamsUseCase<Future<void>, DisconnectFromExternalObjectUseCaseParams> {
  final ObjectRepository objectRepository;

  DisconnectFromExternalObjectUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.disconnectFromExternalObject(
      objectType: params.objectType,
      objectId: params.objectId,
      externalObjectType: params.externalObjectType,
      externalObjectId: params.externalObjectId,
    );
  }
}

class DisconnectFromExternalObjectUseCaseParams {
  final String objectType;
  final String objectId;
  final String externalObjectType;
  final String externalObjectId;

  DisconnectFromExternalObjectUseCaseParams({
    required this.objectType,
    required this.objectId,
    required this.externalObjectType,
    required this.externalObjectId,
  });
}
