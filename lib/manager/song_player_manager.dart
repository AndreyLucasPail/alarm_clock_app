import 'package:alarm_clock_app/data/alarm_song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum SelectedSong { alarmType, plantasia, wake7am, wakeNow }

class SongPlayerManager extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? _currentSong;
  //SelectedSong _selected = SelectedSong.wake7am;
  AlarmSong? _selectedSong;

  String? get currentSong => _currentSong;
  AlarmSong? get selecSong => _selectedSong;

  Future<void> toggleSong(AlarmSong path) async {
    if (_currentSong == path.path) {
      await audioPlayer.stop();
      _currentSong = null;
    } else {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(path.path));
      _currentSong = path.path;
    }
    notifyListeners();
  }

  Future<void> stop() async {
    await audioPlayer.stop();

    _currentSong = null;
    notifyListeners();
  }

  void selectedSong(AlarmSong songSelected) {
    _selectedSong = songSelected;
    notifyListeners();
  }
}
