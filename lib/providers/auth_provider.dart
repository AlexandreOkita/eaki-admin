import 'package:eaki_admin/repositories/auth_repository.dart';
import 'package:eaki_admin/repositories/id_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedState = StateProvider<bool>((ref) {
  return false;
});

final checkTokenProvider = FutureProvider<bool>((ref) async {
  final token = ref.read(idRepository).getId();
  if (token == null) {
    return false;
  }
  return ref.read(authRepository).isTokenValid(token);
});
