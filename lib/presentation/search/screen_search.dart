import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/domain/core/debouncer/debouncer.dart';
import 'package:netflix_clone/presentation/search/widget/search_dirty.dart';
import 'package:netflix_clone/presentation/search/widget/search_idle.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
      print("call");
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: kLightColor),
                backgroundColor: kDimColor!.withOpacity(0.4),
                onChanged: (value) => {
                  if (value.isNotEmpty)
                    {
                      _debouncer.run(() {
                        BlocProvider.of<SearchBloc>(context)
                            .add(SearchMovie(movieQuery: value));
                      })
                    }
                },
              ),
              kHeight20,
              Expanded(child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.searchResultList.isEmpty) {
                    return const SearchIdleWidget();
                  }
                  return const SearchDirtyWidget();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
