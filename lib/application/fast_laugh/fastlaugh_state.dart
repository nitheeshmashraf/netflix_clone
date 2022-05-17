part of 'fastlaugh_bloc.dart';

@freezed
class FastlaughState with _$FastlaughState {
  const factory FastlaughState(
      {required List<Downloads> videoList,
      required bool isLoading,
      required bool isError,
      @Default([]) List<int> likedVideoIds}) = _Initial;

  factory FastlaughState.initial() => const FastlaughState(
      videoList: [], isLoading: false, isError: false, likedVideoIds: []);
}
