import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widget/app_bar.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);

  final _widgetList = [
    const _SmartDownloads(),
    const _Introduction(),
    const _Buttons()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            child: HomeAppBar(
              title: "Downloads",
              showTextTitle: true,
            ),
            preferredSize: Size.fromHeight(50)),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _widgetList[index],
            separatorBuilder: (context, index) => kHeight50,
            itemCount: _widgetList.length));
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: kButtonColor,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Setup",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ),
        kHeight10,
        SizedBox(
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: kLightColor,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "See what you can download",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: backgroundColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _Introduction extends StatelessWidget {
  const _Introduction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final imageList = [
      "https://www.themoviedb.org/t/p/w440_and_h660_face/drgMcyTsySQBnUPGaBThCHGdlWT.jpg",
      "https://www.themoviedb.org/t/p/w440_and_h660_face/zZwbntqdfKdVgzH1RoMHa99g0mJ.jpg",
      "https://www.themoviedb.org/t/p/w440_and_h660_face/wFjboE0aFZNbVOF05fzrka9Fqyx.jpg",
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          " Introducing Downloads for You",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et blandit tellus, tempor elementum sem. Suspendisse ante est, mattis ut lectus nec, imperdiet convallis lectus",
          style: TextStyle(fontSize: ksmallFontSize),
          textAlign: TextAlign.center,
        ),
        MovieImageSpread(size: size, imageList: imageList),
      ],
    );
  }
}

class MovieImageSpread extends StatelessWidget {
  const MovieImageSpread({
    Key? key,
    required this.size,
    required this.imageList,
  }) : super(key: key);

  final Size size;
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });

    return SizedBox(
      height: size.width,
      width: size.width,
      child: BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) => state.isLoading ||
                  state.downloads.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(180, 88, 85, 85),
                        radius: size.width * 0.3,
                      ),
                    ),
                    DownloadsImageWidget(
                      size: Size(size.width * 0.3, size.width * 0.38),
                      angle: 20,
                      color: Colors.amber,
                      imageList:
                          "$imageBaseUrl${state.downloads[2].posterPath}",
                      margin: const EdgeInsets.only(left: 130, bottom: 40),
                    ),
                    DownloadsImageWidget(
                      size: Size(size.width * 0.3, size.width * 0.38),
                      angle: -20,
                      color: Colors.green,
                      imageList:
                          "$imageBaseUrl${state.downloads[1].posterPath}",
                      margin: const EdgeInsets.only(right: 130, bottom: 40),
                    ),
                    DownloadsImageWidget(
                      size: Size(size.width * 0.33, size.width * 0.44),
                      color: Colors.red,
                      imageList:
                          "$imageBaseUrl${state.downloads[0].posterPath}",
                      margin: const EdgeInsets.only(bottom: 0),
                    )
                  ],
                )),
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.settings),
        kWidth,
        Text("Smart Downloads"),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    Key? key,
    required this.imageList,
    required this.margin,
    required this.color,
    this.angle = 0,
    required this.size,
  }) : super(key: key);

  final String imageList;
  final Color color;
  final EdgeInsets margin;
  final double angle;
  final Size size;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imageList))),
      ),
    );
  }
}
