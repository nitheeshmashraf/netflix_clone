import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/fast_laugh/widget/video_list_item.dart';

class NewAndHotCardWidget extends StatelessWidget {
  const NewAndHotCardWidget({
    Key? key,
    required this.card,
    required this.month,
    required this.day,
    required this.movieName,
    required this.subtext,
    required this.description,
    required this.image,
  }) : super(key: key);
  final int card;
  final String month;
  final int? day;
  final String movieName;
  final String subtext;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        card == 0
            ? Column(
                children: [
                  Text(month),
                  Text(
                    day.toString(),
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: kLightColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Container(),
        card == 0 ? kWidth : Container(),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imageBaseUrl + image))),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.volume_mute)),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      movieName,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: kLightColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  card == 0
                      ? Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              VideoActionsWidget(
                                title: "Remind Me",
                                icon: Icons.notifications,
                                onPress: () {},
                                textSize: 11,
                                iconSize: 25,
                                textColor: kDimColor!,
                              ),
                              VideoActionsWidget(
                                title: "Info",
                                icon: Icons.info_outline,
                                onPress: () {},
                                textSize: 11,
                                iconSize: 30,
                                textColor: kDimColor!,
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              VideoActionsWidget(
                                title: "Share",
                                icon: Icons.share,
                                onPress: () {},
                                textSize: 11,
                                iconSize: 25,
                                textColor: kDimColor!,
                              ),
                              VideoActionsWidget(
                                title: "My List",
                                icon: Icons.add,
                                onPress: () {},
                                textSize: 11,
                                iconSize: 35,
                                textColor: kDimColor!,
                              ),
                              VideoActionsWidget(
                                title: "Play",
                                icon: Icons.play_arrow,
                                onPress: () {},
                                textSize: 11,
                                iconSize: 35,
                                textColor: kDimColor!,
                              ),
                            ],
                          ),
                        )
                ],
              ),
              Text(
                subtext,
                style: TextStyle(color: kDimColor, fontSize: kTextSize * 0.8),
              ),
              kHeight20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: NetworkImage(logoUrl))),
                  ),
                  const Text(
                    "FILM",
                    style: TextStyle(fontSize: 10, letterSpacing: 2),
                  ),
                ],
              ),
              Text(
                movieName,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: kLightColor, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Text(
                description,
                style: TextStyle(color: kDimColor, fontSize: kTextSize * 0.8),
              ),
            ],
          ),
        )
      ],
    );
  }
}
