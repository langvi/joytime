class CommonState {
  final bool isLoading;
  CommonState({this.isLoading = false});
  CommonState copyWith({
    bool? isLoading,
  }) {
    return CommonState(isLoading: isLoading ?? this.isLoading);
  }
}
