import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/models/hot_and_new/hot_and_new_response/hot_and_new_response.dart';
import 'package:netflix_clone/domain/models/hot_and_new/hot_and_new_service.dart';

part 'hotandnew_event.dart';
part 'hotandnew_state.dart';
part 'hotandnew_bloc.freezed.dart';

@injectable
class HotandnewBloc extends Bloc<HotandnewEvent, HotandnewState> {
  final HotAndNewService _hotAndNewService;
  ValueNotifier<int> tabSelected = ValueNotifier(0);

  HotandnewBloc(this._hotAndNewService) : super(HotandnewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      emit(HotandnewState(
          comingSoonList: [],
          everyoneIsWatchingList: state.everyoneIsWatchingList,
          isLoading: true,
          isError: false,
          monthNames: state.monthNames));
      final _result = await _hotAndNewService.getHotandNewMovieData();
      emit(_result.fold(
          (l) => HotandnewState(
              comingSoonList: [],
              everyoneIsWatchingList: state.everyoneIsWatchingList,
              isLoading: false,
              isError: true,
              monthNames: state.monthNames),
          (r) => HotandnewState(
                comingSoonList: r.results,
                everyoneIsWatchingList: state.everyoneIsWatchingList,
                isLoading: false,
                isError: false,
                monthNames: state.monthNames,
              )));
    });

    on<LoadDataInEveryoneisWatching>((event, emit) async {
      emit(HotandnewState(
          comingSoonList: state.comingSoonList,
          everyoneIsWatchingList: [],
          isLoading: true,
          isError: false,
          monthNames: state.monthNames));
      final _result = await _hotAndNewService.getHotandNewTVData();
      emit(_result.fold(
          (l) => HotandnewState(
              comingSoonList: state.comingSoonList,
              everyoneIsWatchingList: [],
              isLoading: false,
              isError: true,
              monthNames: state.monthNames),
          (r) => HotandnewState(
              comingSoonList: state.comingSoonList,
              everyoneIsWatchingList: r.results,
              isLoading: false,
              isError: false,
              monthNames: state.monthNames)));
    });

    on<SwitchTab>((event, emit) async {
      tabSelected.value = event.id;
      tabSelected.notifyListeners();
    });
  }
}
