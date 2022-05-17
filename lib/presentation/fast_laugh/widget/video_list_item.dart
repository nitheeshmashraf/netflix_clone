import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/domain/models/downloads/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget(
      {Key? key, required this.widget, required this.movieData})
      : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  const VideoListItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        Container(
          color: Colors.accents[index],
          child: FastLaughVideoPlayer(
            onStateChanged: (value) {},
            videoUrl: videoUrl,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                      backgroundColor: kDarkColor.withOpacity(0.5),
                      radius: 30,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.volume_mute,
                          ))),
                  VideoRightWidgets(index: index)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class VideoRightWidgets extends StatelessWidget {
  const VideoRightWidgets({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: posterPath == null
              ? null
              : NetworkImage(imageBaseUrl + posterPath),
          radius: 30,
          backgroundColor: kLightColor,
        ),
        ValueListenableBuilder(
          valueListenable: likedVideoIdsNotifier,
          builder: (context, Set<int> newLikedListIds, _) {
            if (newLikedListIds.contains(index)) {
              return VideoActionsWidget(
                title: "Liked",
                icon: Icons.favorite_rounded,
                onPress: () {
                  BlocProvider.of<FastlaughBloc>(context)
                      .add(UnlikeVideo(id: index));
                },
              );
            }
            return VideoActionsWidget(
              title: "LOL",
              icon: Icons.emoji_emotions,
              onPress: () {
                // log("message");
                BlocProvider.of<FastlaughBloc>(context)
                    .add(LikeVideo(id: index));
              },
            );
          },
        ),
        BlocBuilder<FastlaughBloc, FastlaughState>(builder: (context, state) {
          if (state.likedVideoIds.contains(index)) {
            return VideoActionsWidget(
              title: "Remove",
              icon: Icons.add,
              onPress: () {
                BlocProvider.of<FastlaughBloc>(context)
                    .add(LikeVideo(id: index));
              },
            );
          }
          return VideoActionsWidget(
            title: "My List",
            icon: Icons.add,
            onPress: () {},
          );
        }),
        VideoActionsWidget(
          title: "Share",
          icon: Icons.share,
          onPress: () {
            final movieTitle =
                VideoListItemInheritedWidget.of(context)?.movieData.title;
            if (movieTitle != null) {
              Share.share(movieTitle);
            }
          },
        ),
        VideoActionsWidget(
          title: "Play",
          icon: Icons.play_arrow,
          onPress: () {},
        )
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  const VideoActionsWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textSize = kTextSize,
    this.textColor = kLightColor,
    this.iconSize = kIconSize,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function onPress;
  final double textSize;
  final double iconSize;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          IconButton(
              onPressed: () => onPress(),
              icon: Icon(
                icon,
                size: iconSize,
                color:
                    icon == Icons.favorite_rounded ? Colors.red : kLightColor,
              )),
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: textSize),
          )
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {Key? key, required this.videoUrl, required this.onStateChanged})
      : super(key: key);

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController))
            : const Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
                color: kLightColor,
              )));
  }
}
