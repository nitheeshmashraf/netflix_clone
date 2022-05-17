import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/application/hot_and_new/hotandnew_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/screen_home.dart';
import 'package:netflix_clone/presentation/home/widget/app_bar.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/elevated_white_button.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/new_and_hot_card.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<HotandnewBloc>(context).add(const LoadDataInComingSoon());
    BlocProvider.of<HotandnewBloc>(context)
        .add(const LoadDataInEveryoneisWatching());

    return Scaffold(
      appBar: const PreferredSize(
          child: HomeAppBar(
            title: "New & Hot",
            showTextTitle: true,
          ),
          preferredSize: Size.fromHeight(50)),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (context, index, _) => NotificationListener<
                UserScrollNotification>(
            onNotification: ((notification) {
              log(scrollNotifier.value.toString());
              if (notification.direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (notification.direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            }),
            child: ValueListenableBuilder(
              builder: (context, value, _) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedWhiteButton(
                          title: "Coming Soon",
                          icon: Icons.ramen_dining,
                          selected: value == 0 ? true : false,
                          onPress: () {
                            BlocProvider.of<HotandnewBloc>(context)
                                .add(const SwitchTab(id: 0));
                          },
                        ),
                        ElevatedWhiteButton(
                          selected: value == 0 ? false : true,
                          title: "Everyone's Watching",
                          icon: Icons.face,
                          onPress: () {
                            BlocProvider.of<HotandnewBloc>(context)
                                .add(const SwitchTab(id: 1));
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<HotandnewBloc, HotandnewState>(
                        builder: (context, state) {
                      final listHead = value == 0
                          ? state.comingSoonList
                          : state.everyoneIsWatchingList;
                      return RefreshIndicator(
                        onRefresh: (() async => value == 0
                            ? BlocProvider.of<HotandnewBloc>(context)
                                .add(const LoadDataInComingSoon())
                            : BlocProvider.of<HotandnewBloc>(context)
                                .add(const LoadDataInEveryoneisWatching())),
                        child: LimitedBox(
                          maxHeight: size.height * 0.72,
                          child: state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  itemCount: listHead.length,
                                  separatorBuilder: (context, index) =>
                                      kHeight10,
                                  itemBuilder: (context, index) {
                                    final parsedDate = DateTime.parse(
                                        listHead[index].releaseDate ??
                                            "2022-01-01");
                                    final weekday =
                                        DateFormat('EEEE').format(parsedDate);
                                    return NewAndHotCardWidget(
                                        card: value == 0 ? 0 : 1,
                                        month: state
                                            .monthNames[parsedDate.month - 1],
                                        day: parsedDate.day,
                                        image: listHead[index].backdropPath ??
                                            "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
                                        movieName: value == 0
                                            ? listHead[index].originalTitle ??
                                                ""
                                            : listHead[index].originalName ??
                                                "",
                                        subtext: "Coming on $weekday",
                                        description:
                                            listHead[index].overview ?? "");
                                  }),
                        ),
                      );
                    }),
                  ],
                );
              },
              valueListenable:
                  BlocProvider.of<HotandnewBloc>(context).tabSelected,
            )),
      )),
    );
  }
}
