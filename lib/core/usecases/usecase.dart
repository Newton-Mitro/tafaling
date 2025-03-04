abstract class UseCase<Type, Params> {
  Future<Type> call({Params Params});
}
