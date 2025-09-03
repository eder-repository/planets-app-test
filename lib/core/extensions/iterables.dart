import 'dart:core';

extension IterableX<E> on Iterable<E> {
  List<T> mapList<T>(T Function(E element) f) {
    return map(f).toList();
  }
}
