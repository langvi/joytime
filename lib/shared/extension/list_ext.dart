extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension NullList<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension ListExtension<E> on List<E> {
  void addIf(dynamic condition, E item) {
    if (condition is bool Function()) condition = condition();
    if (condition is bool && condition) add(item);
  }
}
