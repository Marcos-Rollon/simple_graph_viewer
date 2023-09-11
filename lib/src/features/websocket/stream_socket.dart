import 'dart:async';

class StreamSocket {
  final _socketResponse = StreamController<String>.broadcast();

  final String event;

  StreamSocket(
    this.event,
  );

  void Function(String) get addValue => _socketResponse.sink.add;

  Stream<String> get value => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }

  @override
  String toString() => 'StreamSocket(event: $event)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StreamSocket && other.event == event;
  }

  @override
  int get hashCode => event.hashCode;
}
