import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getNavigationsProvider = Provider<GetNavigationsUseCase>(
  (ref) => GetNavigationsUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetNavigationsUseCase
    implements
        ParamsUseCase<Future<List<Map<String, dynamic>>>,
            GetNavigationsUseCaseParams> {
  final ObjectRepository objectRepository;

  GetNavigationsUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getNavigations(
      fromId: params.fromId,
      fromType: params.fromType,
    );
  }
}

class GetNavigationsUseCaseParams {
  final String fromId;
  final String fromType;

  GetNavigationsUseCaseParams({required this.fromId, required this.fromType});
}
