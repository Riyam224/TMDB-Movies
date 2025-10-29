import 'exceptions.dart';
import 'failures.dart';

Failure handleException(Object error) {
  if (error is ServerException) {
    return ServerFailure(error.message);
  } else if (error is CacheException) {
    return CacheFailure(error.message);
  } else if (error is NetworkException) {
    return NetworkFailure(error.message);
  } else if (error is LocalStorageException) {
    return LocalStorageFailure(error.message);
  } else {
    return UnknownFailure(error.toString());
  }
  
}
