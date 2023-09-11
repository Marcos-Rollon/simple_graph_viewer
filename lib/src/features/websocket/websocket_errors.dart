class WebsocketError implements Exception {
  final WebsocketErrorType? type;

  WebsocketError({this.type});

  @override
  String toString() => type != null ? type!.value : '$runtimeType Exception';
}

enum WebsocketErrorType {
  generic,
  cantReach,
  disconnected,
  timeout,
  listenerDoesNotExists,
}

extension WebsocketErrorTypeDefinition on WebsocketErrorType {
  String get value {
    switch (this) {
      case WebsocketErrorType.generic:
        return "Websocket Error";
      case WebsocketErrorType.cantReach:
        return "Cannot Reach Server";
      case WebsocketErrorType.disconnected:
        return "Disconnected from server";
      case WebsocketErrorType.timeout:
        return "Timeout reached";
      case WebsocketErrorType.listenerDoesNotExists:
        return "The listener that you are trying to remove does not exists";
    }
  }
}
