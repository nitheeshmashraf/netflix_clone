import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widget/app_bar.dart';
import 'package:netflix_clone/presentation/home/widget/bottom_positioned_buttons.dart';
import 'package:netflix_clone/presentation/home/widget/gradient_overlay.dart';
import 'package:netflix_clone/presentation/home/widget/movie_scroll_h.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(false);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: ((context, value, child) =>
          NotificationListener<UserScrollNotification>(
            onNotification: ((notification) {
              if (notification.direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (notification.direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            }),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Stack(children: [
                      Container(
                        width: double.infinity,
                        height: size.height * 0.75,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageUrl))),
                      ),
                      const GradientOverlay(),
                      const BottomPositionedButtons(),
                    ]),
                    kHeight20,
                    const MovieScrollH(title: "Released in the past year"),
                    kHeight20,
                    const MovieScrollH(title: "Trending Now"),
                    kHeight20,
                    const MovieScrollH(
                      title: "Top 10 TV Shows in India Today",
                      showIndex: true,
                    ),
                    kHeight20,
                    const MovieScrollH(
                      title: "Tense Drama",
                    ),
                    kHeight20,
                    const MovieScrollH(
                      title: "South Indian Cinema",
                    ),
                  ],
                ),
                scrollNotifier.value
                    ? const PreferredSize(
                        child: HomeAppBar(
                          showTextButton: true,
                        ),
                        preferredSize: Size.fromHeight(50))
                    : Container()
              ],
            ),
          )),
    )));
  }
}
