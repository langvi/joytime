class AppState {
  final String languageCode;
  AppState({
    this.languageCode = 'vi',
  });

  AppState copyWith({
    String? languageCode,
  }) {
    return AppState(
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
