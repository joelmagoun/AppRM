import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getObjectListProvider = Provider<GetObjectListUseCase>(
  (ref) => GetObjectListUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetObjectListUseCase
    implements
        ParamsUseCase<Future<List<Map<String, dynamic>>>,
            GetObjectListUseCaseParams> {
  final ObjectRepository objectRepository;

  GetObjectListUseCase({required this.objectRepository});

  @override
  execute(params) {
    var processedSortValues = <String, String>{};
    params.sortValues.forEach((k, v) {
      if (v != null) {
        processedSortValues[k] = v;
      }
    });

    var processedFilterValues = <String, String>{};
    params.filterValues.forEach((k, v) {
      if (v != null) {
        processedFilterValues[k] = v;
      }
    });

    return objectRepository.getObjectList(
      tableName: params.objectType,
      sortValues: processedSortValues,
      filterValues: processedFilterValues,
      searchFields: params.searchFields,
      searchValue: params.searchValue,
    );
  }
}

class GetObjectListUseCaseParams {
  final String objectType;
  final Map<String, String?> sortValues;
  final Map<String, String?> filterValues;
  final List<String> searchFields;
  final String? searchValue;

  GetObjectListUseCaseParams({
    required this.objectType,
    required this.sortValues,
    required this.filterValues,
    required this.searchFields,
    this.searchValue,
  });
}
