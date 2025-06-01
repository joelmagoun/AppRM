import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final createObjectFromExternalObjectProvider =
    Provider<CreateObjectFromExternalObjectUseCase>(
  (ref) => CreateObjectFromExternalObjectUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class CreateObjectFromExternalObjectUseCase
    implements
        ParamsUseCase<Future<void>,
            CreateObjectFromExternalObjectUseCaseParams> {
  final ObjectRepository objectRepository;

  CreateObjectFromExternalObjectUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.createObjectFromExternalObject(
      objectType: params.objectType,
      externalObjectType: params.externalObjectType,
      externalObjectId: params.externalObjectId,
      data: params.data,
    );
  }
}

class CreateObjectFromExternalObjectUseCaseParams {
  final String objectType;
  final String externalObjectType;
  final String externalObjectId;
  final Map<String, dynamic> data;

  CreateObjectFromExternalObjectUseCaseParams({
    required this.objectType,
    required this.externalObjectType,
    required this.externalObjectId,
    required this.data,
  });
}
