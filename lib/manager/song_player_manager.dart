import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SongPlayerManager extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? _currentSong;
  AnimationController? _controller;

  String? get currentSong => _currentSong;
  AnimationController? get controller => _controller;

  void initController(TickerProvider vsync) {
    _controller = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> toggleSong() {}
}
