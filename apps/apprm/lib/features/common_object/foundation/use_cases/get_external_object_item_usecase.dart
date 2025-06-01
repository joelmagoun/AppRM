import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../external_object_repository.dart';
import 'common_usecase.dart';

final getExternalObjectItemProvider = Provider<GetExternalObjectItemUseCase>(
  (ref) => GetExternalObjectItemUseCase(
    externalObjectRepository: ref.read(externalObjectRepositoryProvider),
  ),
);

class GetExternalObjectItemUseCase
    implements
        ParamsUseCase<Future<Map<String, dynamic>>,
            GetExternalObjectItemUseCaseParams> {
  final ExternalObjectRepository externalObjectRepository;

  GetExternalObjectItemUseCase({required this.externalObjectRepository});

  @override
  execute(params) {
    return externalObjectRepository.getItem(
      tableName: params.externalObjectType,
      externalObjectId: params.externalObjectId,
    );
  }
}

class GetExternalObjectItemUseCaseParams {
  final String externalObjectType;
  final String externalObjectId;

  GetExternalObjectItemUseCaseParams({
    required this.externalObjectType,
    required this.externalObjectId,
  });
}
