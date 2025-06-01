import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final createObjectProvider = Provider<CreateObjectUseCase>(
  (ref) => CreateObjectUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class CreateObjectUseCase
    implements ParamsUseCase<Future<void>, CreateObjectUseCaseParams> {
  final ObjectRepository objectRepository;

  CreateObjectUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.createObject(
      tableName: params.objectType,
      data: params.data,
    );
  }
}

class CreateObjectUseCaseParams {
  final String objectType;
  final Map<String, dynamic> data;

  CreateObjectUseCaseParams({
    required this.objectType,
    required this.data,
  });
}
