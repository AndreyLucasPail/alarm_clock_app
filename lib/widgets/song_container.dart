import 'dart:math' as math;

import 'package:alarm_clock_app/data/alarm_song.dart';
import 'package:alarm_clock_app/manager/song_player_manager.dart';
import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongContainer extends StatefulWidget {
  const SongContainer({super.key, required this.song});

  final AlarmSong song;

  @override
  State<SongContainer> createState() => _SongContainerState();
}

class _SongContainerState extends State<SongContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleAnimation(bool isPlaying) {
    if (isPlaying) {
      _controller.repeat();
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongPlayerManager>(
      builder: (_, songManeger, __) {
        final isCurrentSong = songManeger.currentSong == widget.song.path;
        final bool selectSong = songManeger.currentSong == widget.song.path;
        handleAnimation(isCurrentSong);
        return InkWell(
          onTap: () async {
            await songManeger.toggleSong(widget.song);
            songManeger.selectedSong(widget.song);
          },
          child: Container(
            height: 250,
            width: 180,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: widget.song.color,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: selectSong ? CustomColors.green : widget.song.color,
                width: 10,
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: Image.asset("assets/disco-de-vinil.png"),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
