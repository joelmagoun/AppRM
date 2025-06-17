import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getUserStoryStepsProvider = Provider<GetUserStoryStepsUseCase>(
  (ref) => GetUserStoryStepsUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetUserStoryStepsUseCase
    implements ParamsUseCase<Future<List<Map<String, dynamic>>>, GetUserStoryStepsUseCaseParams> {
  final ObjectRepository objectRepository;

  GetUserStoryStepsUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getUserStorySteps(storyId: params.storyId);
  }
}

class GetUserStoryStepsUseCaseParams {
  final String storyId;

  GetUserStoryStepsUseCaseParams({required this.storyId});
}
