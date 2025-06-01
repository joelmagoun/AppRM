import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final connectToExternalObjectProvider =
    Provider<ConnectToExternalObjectUseCase>(
  (ref) => ConnectToExternalObjectUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class ConnectToExternalObjectUseCase
    implements
        ParamsUseCase<Future<void>, ConnectToExternalObjectUseCaseParams> {
  final ObjectRepository objectRepository;

  ConnectToExternalObjectUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.connectToExternalObject(
      objectType: params.objectType,
      objectId: params.objectId,
      externalObjectType: params.externalObjectType,
      externalObjectId: params.externalObjectId,
    );
  }
}

class ConnectToExternalObjectUseCaseParams {
  final String objectType;
  final String objectId;
  final String externalObjectType;
  final String externalObjectId;

  ConnectToExternalObjectUseCaseParams({
    required this.objectType,
    required this.objectId,
    required this.externalObjectType,
    required this.externalObjectId,
  });
}
