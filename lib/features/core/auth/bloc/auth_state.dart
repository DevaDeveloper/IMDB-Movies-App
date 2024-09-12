part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class ErrorAuth extends AuthState {
  final Failure failure;

  const ErrorAuth({required this.failure});

  @override
  List<Object> get props => [];
}

class AuthenticatedUser extends AuthState {
  final String userId;

  const AuthenticatedUser({
    required this.userId,
  });

  @override
  List<Object> get props => [
        userId,
      ];

  AuthenticatedUser copyWith({
    String? userId,
  }) {
    return AuthenticatedUser(
      userId: userId ?? this.userId,
    );
  }
}

class UnauthenticatedUser extends AuthState {
  const UnauthenticatedUser();

  @override
  List<Object> get props => [];
}
