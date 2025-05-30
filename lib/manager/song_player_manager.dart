import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum SelectedSong { alarmType, plantasia, wake7am, wakeNow }

class SongPlayerManager extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? _currentSong;
  SelectedSong _selected = SelectedSong.wake7am;

  String? get currentSong => _currentSong;
  SelectedSong? get selected => _selected;

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

  void selectedSong(SelectedSong songSelected) {
    _selected = songSelected;
    notifyListeners();
  }
}
