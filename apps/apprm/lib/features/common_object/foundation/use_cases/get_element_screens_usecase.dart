import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getElementScreensProvider = Provider<GetElementScreensUseCase>(
  (ref) => GetElementScreensUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetElementScreensUseCase
    implements
        ParamsUseCase<Future<List<Map<String, dynamic>>>,
            GetElementScreensUseCaseParams> {
  final ObjectRepository objectRepository;

  GetElementScreensUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getElementScreens(elementId: params.elementId);
  }
}

class GetElementScreensUseCaseParams {
  final String elementId;

  GetElementScreensUseCaseParams({required this.elementId});
}
