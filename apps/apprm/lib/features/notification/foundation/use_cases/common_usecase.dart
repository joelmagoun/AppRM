abstract class ParamsUseCase<R, P> {
  R execute(P params);
}

abstract class NoParamsUseCase<R> {
  R execute();
}
