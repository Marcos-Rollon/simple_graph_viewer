import 'dart:convert';
import 'package:either_dart/either.dart';
import 'stream_socket.dart';
import 'websocket_errors.dart';
// ignore: library_prefixes
import "package:socket_io_client/socket_io_client.dart" as IO;

class WebsocketService {
  IO.Socket? _socket;
  final String _ip;
  List<StreamSocket> _listeners = [];

  WebsocketService(this._ip);

  // PUBLIC API
  Function()? onConnect;
  Function(String error)? onConnectError;
  Function(String reason)? onDisconnect;

  bool get isConnected {
    return !(_socket == null);
  }

  void connect() {
    if (_socket != null) {
      return;
    }
    _socket = IO.io(
        _ip,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            //.setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    _setup();
    _socket?.connect();
  }

  void disconnect() {
    removeAllListeners();
    _socket?.disconnect();
    _socket?.dispose();
    _socket?.destroy();
    _socket = null;
  }

  StreamSocket getListener(String event) {
    // Check if there is already listener for that event
    var possibleIndex =
        _listeners.indexWhere((element) => element.event == event);
    if (possibleIndex >= 0) {
      return _listeners[possibleIndex];
    }
    // If not, create one
    final listener = StreamSocket(event);
    _listeners.add(listener);
    // Also create the event if the socket is alive
    _socket?.on(event, (data) {
      listener.addValue(json.encode(data));
    });

    return listener;
  }

  Either<WebsocketError, void> removeListener(String event) {
    var possibleIndex =
        _listeners.indexWhere((element) => element.event == event);
    if (possibleIndex == -1) {
      return Left(
          WebsocketError(type: WebsocketErrorType.listenerDoesNotExists));
    }
    _listeners[possibleIndex].dispose();
    _listeners.removeAt(possibleIndex);
    return const Right(null);
  }

  void send(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  void removeAllListeners() {
    for (var i = 0; i < _listeners.length; i++) {
      _listeners[i].dispose();
      _socket?.off(_listeners[i].event);
    }
    _listeners = [];
  }

  void addListener(String event, Function(String) callback) {
    _socket?.on(event, ((data) => callback(data)));
  }

  // HELPERS

  void _setup() {
    _socket?.onConnect((_) => onConnect?.call());
    _socket?.onDisconnect(
      (reason) {
        if (reason is String) {
          onDisconnect?.call(reason);
        }
        // Remove all the streams should be responsability of user class?
        removeAllListeners();
      },
    );
    _socket?.onConnectError((reason) {
      if (reason is String) {
        onConnectError?.call(reason);
      }
    });
    // If there are listeners ready, re-assign the events
    _asignListenerToSocket();
  }

  void _asignListenerToSocket() {
    for (var i = 0; i < _listeners.length; i++) {
      _socket?.on(
        _listeners[i].event,
        (data) => _listeners[i].addValue(
          jsonEncode(data),
        ),
      );
    }
  }
}
