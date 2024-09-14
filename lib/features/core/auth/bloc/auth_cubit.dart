import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_movies_app/features/core/auth/repository/auth_repository.dart';
import 'package:imdb_movies_app/models/failure_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({
    required this.authRepository,
    required String? token,
    required String? userId,
  }) : super(AuthInitial()) {
    emit(AuthenticatedUser(userId: 'uuid'));
  }

  Future<bool> login(String email, String password) async {
    emit(const AuthenticatedUser(
      userId: 'uuid',
    ));

    return true;
  }

  Future<bool> logOut() async {
    emit(const UnauthenticatedUser());

    return true;
  }
}
