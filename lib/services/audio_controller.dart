import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioControllerProvider = Provider((ref) => AudioController());

class AudioController {
  final AudioPlayer audioPlayer = AudioPlayer();

  playFromInternet(String url) async {
    await audioPlayer.play(url);
  }

  play(String path) async {
    await audioPlayer.play(path, isLocal: true);
  }
}
