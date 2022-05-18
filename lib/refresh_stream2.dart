import 'dart:async';

class RefreshStream2<T> {
  late StreamController<T> _controller;
  late StreamSink<T> _sink;
  final Duration interval;
  late bool _active;

  RefreshStream2(this.interval) {
    _controller = StreamController();
    _sink = _controller.sink;
  }

  void close() {
    _active = false;
    _controller.close();
  }

  Future<void> call(Future<T> Function() exec) async {
    _active = true;
    while (true) {
      await Future.delayed(interval);
      final T data = await exec();
      _sink.add(data);
    }
  }

  Stream<T> get stream => _controller.stream;
}
