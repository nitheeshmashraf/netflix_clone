import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix_clone/presentation/fast_laugh/widget/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) =>
        BlocProvider.of<FastlaughBloc>(context).add(const Initialize()));
    return Scaffold(
      body: SafeArea(child: BlocBuilder<FastlaughBloc, FastlaughState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isError) {
            return const Center(child: Text("Error while fetching data"));
          } else if (state.videoList.isEmpty) {
            return const Center(child: Text("No content to load"));
          }
          return PageView(
            scrollDirection: Axis.vertical,
            children: List.generate(
                state.videoList.length,
                (index) => VideoListItemInheritedWidget(
                    widget: VideoListItem(
                      key: Key(index.toString()),
                      index: index,
                    ),
                    movieData: state.videoList[index])),
          );
        },
      )),
    );
  }
}
