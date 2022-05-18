import 'dart:async';

/// 2 ways of creating streams
/// 1-> using stream generators async* & yield
/// 2-> using streamController & sink
class RefreshStream<T> {
  final Duration interval;
  late bool _active;

  RefreshStream(this.interval) {
    _active = true;
  }

  Stream<T> call(Future<T> Function() exec) async* {
    while (_active) {
      await Future.delayed(interval);
      final T data = await exec();
      yield data;
    }
  }

  void close() {
    _active = false;
  }
}
