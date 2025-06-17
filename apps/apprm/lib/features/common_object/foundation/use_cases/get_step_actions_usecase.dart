import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getStepActionsProvider = Provider<GetStepActionsUseCase>(
  (ref) => GetStepActionsUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetStepActionsUseCase
    implements ParamsUseCase<Future<List<Map<String, dynamic>>>, GetStepActionsUseCaseParams> {
  final ObjectRepository objectRepository;

  GetStepActionsUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getStepActions(stepId: params.stepId);
  }
}

class GetStepActionsUseCaseParams {
  final String stepId;

  GetStepActionsUseCaseParams({required this.stepId});
}
