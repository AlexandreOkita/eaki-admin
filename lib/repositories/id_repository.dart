
// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final idRepository = Provider((ref) => IdRepository());

class IdRepository {
  final Storage _localStorage = window.localStorage;

  Future save(String id) async {
    _localStorage['token'] = sha1.convert(utf8.encode(id)).toString();
  }

  String? getId() => _localStorage['token'];

  Future invalidate() async {
    _localStorage.remove('token');
  }
}
