import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SongPlayerManager extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? _currentSong;
  bool _isPlaying = false;

  String? get currentSong => _currentSong;
  bool? get isPlaying => _isPlaying;

  Future<void> toggleSong(String path) async {
    if (_currentSong == path) {
      await audioPlayer.stop();
      _currentSong = null;
    } else {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(path));
      _currentSong = path;
    }
    notifyListeners();
  }

  Future<void> stop() async {
    await audioPlayer.stop();

    _currentSong = null;
    notifyListeners();
  }

  void start(String path) {
    if (_currentSong == path) {
      _isPlaying = !_isPlaying;
    } else {
      _isPlaying = false;
    }
    ;
    notifyListeners();
  }
}
