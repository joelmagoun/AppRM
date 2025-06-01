import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../external_object_repository.dart';
import 'common_usecase.dart';

final getExternalObjectListProvider = Provider<GetExternalObjectListUseCase>(
  (ref) => GetExternalObjectListUseCase(
    externalObjectRepository: ref.read(externalObjectRepositoryProvider),
  ),
);

class GetExternalObjectListUseCase
    implements
        ParamsUseCase<Future<List<Map<String, dynamic>>>,
            GetExternalObjectListUseCaseParams> {
  final ExternalObjectRepository externalObjectRepository;

  GetExternalObjectListUseCase({required this.externalObjectRepository});

  @override
  execute(params) {
    return externalObjectRepository.getList(
      tableName: params.externalObjectType,
    );
  }
}

class GetExternalObjectListUseCaseParams {
  final String externalObjectType;

  GetExternalObjectListUseCaseParams({
    required this.externalObjectType,
  });
}
