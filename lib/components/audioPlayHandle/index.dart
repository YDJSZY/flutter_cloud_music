import 'package:flutter/material.dart';

class AudioPlayHandle extends StatefulWidget {
  final Function prev;
  final Function play;
  final Function next;
  final bool isPlaying;

  AudioPlayHandle(this.prev, this.play, this.next, this.isPlaying);
  
  @override
  State<StatefulWidget> createState() {
    return _AudioPlayHandle();
  }
}

class _AudioPlayHandle extends State<AudioPlayHandle> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isPlaying = widget.isPlaying;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          child: Icon(Icons.skip_previous, size: 50, color: Colors.white),
          onTap: widget.prev,
        ),
        GestureDetector(
          child: Icon(isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline, size: 80, color: Colors.white),
          onTap: widget.play,
        ),
        GestureDetector(
          child: Icon(Icons.skip_next, size: 50, color: Colors.white),
          onTap: widget.next,
        )
      ],
    );
  }
}