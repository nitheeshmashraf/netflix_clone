part of 'hotandnew_bloc.dart';

@freezed
class HotandnewState with _$HotandnewState {
  const factory HotandnewState({
    required final List<HotAndNewData> comingSoonList,
    required final List<HotAndNewData> everyoneIsWatchingList,
    required bool isLoading,
    required bool isError,
    required final List<String> monthNames,
  }) = _Initial;
  factory HotandnewState.initial() => const HotandnewState(
      comingSoonList: [],
      everyoneIsWatchingList: [],
      isError: false,
      isLoading: false,
      monthNames: [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ]);
}
