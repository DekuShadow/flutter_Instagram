import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../utils/utills.dart';
import 'package:video_player/video_player.dart';

class ReelsCard extends StatefulWidget {
  const ReelsCard({
    super.key,
    required this.width,
    required this.index,
    required this.snap,
  });
  final snap;
  final double width;
  final int index;

  @override
  State<ReelsCard> createState() => _ReelsCardState();
}

class _ReelsCardState extends State<ReelsCard> {
  late VideoPlayerController _controller;
  bool _isMuted = false;

  @override
  void initState() {
    print("${widget.snap['postReels']}");
    super.initState();
    _controller = VideoPlayerController.network("${widget.snap['postReels']}")
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(100)
      ..play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.width > webScreenSize ? widget.width * 0.25 : 0,
          vertical: widget.width > webScreenSize ? 15 : 0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              print("object");
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    _controller.value.isInitialized
                        ? VideoPlayer(
                            _controller,
                          )
                        : Image.network(widget.snap['profImage']),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoProgress(controller: _controller),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          foregroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2023/01/22/13/46/swans-7736415_960_720.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(widget.snap['username']),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "follow",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(widget.snap['description']),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.music_note_outlined,
                          size: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text("thehilarious.ted Original audio"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('23.5k'),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment_outlined,
                        size: 30,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('230'),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        size: 30,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: 30,
                      )),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 400,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                        print("object");
                      });
                    },
                    child: _controller.value.isPlaying
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isMuted
                            ? _controller.setVolume(100)
                            : _controller.setVolume(0);
                        print("object");
                        _isMuted = _controller.value.volume == 0;
                      });
                    },
                    child: _isMuted
                        ? Icon(Icons.volume_off)
                        : Icon(Icons.volume_up),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class VideoProgress extends StatelessWidget {
  const VideoProgress({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      padding: EdgeInsets.zero,
      colors: VideoProgressColors(
        backgroundColor: Colors.white,
        playedColor: Colors.black,
      ),
    );
  }
}
