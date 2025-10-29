abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
