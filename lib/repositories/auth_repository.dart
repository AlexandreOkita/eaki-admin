import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepository(ref, FirebaseFirestore.instance);
});

class AuthRepository {
  final AutoDisposeProviderRef ref;
  final FirebaseFirestore db;

  AuthRepository(this.ref, this.db);

  Future<bool> login(String email, String pass) async {
    print(sha1.convert(utf8.encode(pass)).toString());
    final query = await db
        .collection("auth")
        .where("email", isEqualTo: email)
        .where("pass", isEqualTo: sha1.convert(utf8.encode(pass)).toString())
        .get();
    return query.docs.isNotEmpty;
  }

  Future<bool> isTokenValid(String token) async {
    final query =
        await db.collection("auth").where("pass", isEqualTo: token).get();
    return query.docs.isNotEmpty;
  }
}
