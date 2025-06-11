import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getScreenElementsProvider = Provider<GetScreenElementsUseCase>(
  (ref) => GetScreenElementsUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetScreenElementsUseCase
    implements ParamsUseCase<Future<List<Map<String, dynamic>>>, GetScreenElementsUseCaseParams> {
  final ObjectRepository objectRepository;

  GetScreenElementsUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getScreenElements(screenId: params.screenId);
  }
}

class GetScreenElementsUseCaseParams {
  final String screenId;

  GetScreenElementsUseCaseParams({required this.screenId});
}
