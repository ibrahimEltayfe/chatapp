import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure{
  const AuthFailure(super.message);
}

class NoInternetFailure extends Failure{
  const NoInternetFailure(super.message);
}

class UnExpectedFailure extends Failure{
  const UnExpectedFailure(super.message);
}

class NoUIDFailure extends Failure{
  const NoUIDFailure(super.message);
}

class SaveUIDLocallyFailure extends Failure{
  const SaveUIDLocallyFailure(super.message);
}

class ImageCacheFailure extends Failure{
  const ImageCacheFailure(super.message);
}