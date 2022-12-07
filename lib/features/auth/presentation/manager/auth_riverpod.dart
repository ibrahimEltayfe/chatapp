import 'package:chatapp/core/utils/cache_image_manager.dart';
import 'package:chatapp/core/utils/shared_pref_helper.dart';
import 'package:chatapp/features/auth/data/data_sources/auth_remote.dart';
import 'package:chatapp/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:chatapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_model.dart';
part 'auth_state.dart';

final authRemote = Provider<AuthRemote>((ref) {
  return AuthRemote();
});

final authRepoProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemote);
  final imageCacheManager = ref.read(imageCacheManagerProvider);

  return AuthRepositoryImpl(remote,imageCacheManager);
});

final authProvider = StateNotifierProvider<AuthRiverPod,AuthState>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthRiverPod(authRepo);
});


class AuthRiverPod extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  final UserModel userModel = UserModel();

  AuthRiverPod(this.authRepository) : super(AuthInitial());

  Future<void> signInWithGoogle() async{
    state = AuthLoading();

    final loginWithGoogle = await authRepository.loginWithGoogle(userModel);
    loginWithGoogle.fold(
        (failure) => state = AuthError(failure.message),
        (results) => state = AuthLoggedIn()
    );
  }
}
