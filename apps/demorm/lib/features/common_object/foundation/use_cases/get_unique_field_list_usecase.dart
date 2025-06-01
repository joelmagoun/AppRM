import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getUniqueFieldListProvider = Provider<GetUniqueFieldListUseCase>(
  (ref) => GetUniqueFieldListUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetUniqueFieldListUseCase
    implements
        ParamsUseCase<Future<List<Map<String, dynamic>>>,
            GetUniqueFieldListUseCaseParams> {
  final ObjectRepository objectRepository;

  GetUniqueFieldListUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getUniqueFieldList(
      tableName: params.objectType,
      field: params.field,
    );
  }
}

class GetUniqueFieldListUseCaseParams {
  final String objectType;
  final String field;

  GetUniqueFieldListUseCaseParams({
    required this.objectType,
    required this.field,
  });
}
