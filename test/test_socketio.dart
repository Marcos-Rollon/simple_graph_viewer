import 'package:simple_graph_viewer/src/features/websocket/websocket_service.dart';
import "package:socket_io_client/socket_io_client.dart" as IO;

const WEBSOCKET_SERVER_IP = "http://localhost:8000";
void main() {
  websocketServiceSensorDataTest();
}

void libraryTestWithoutClass() {
  var socket = IO.io(
      WEBSOCKET_SERVER_IP,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          //.setExtraHeaders({'foo': 'bar'}) // optional
          .build());
  socket.onConnect((_) => print("Socket connected"));
  socket.onDisconnect(
    (reason) {
      if (reason is String) {
        print(reason);
      }
    },
  );
  socket.onConnectError((reason) {
    if (reason is String) {
      print(reason);
    }
  });
  socket.connect();
}

void websocketServiceConnectTest() {
  var websocketService = WebsocketService(WEBSOCKET_SERVER_IP);
  websocketService.onConnect = () => print("Websocket connected");
  websocketService.onConnectError =
      (reason) => print("On connect error " + reason);
  websocketService.onDisconnect =
      (reason) => print("Websocket disconnected " + reason);
  websocketService.connect();
}

void websocketServiceSensorDataTest() {
  var websocketService = WebsocketService(WEBSOCKET_SERVER_IP);
  websocketService.onConnect = () => print("Websocket connected");
  websocketService.onConnectError =
      (reason) => print("On connect error " + reason);
  websocketService.onDisconnect =
      (reason) => print("Websocket disconnected " + reason);
  var sensorDataStream = websocketService.getListener("sensorData");
  sensorDataStream.value.listen((sensorData) {
    print(sensorData);
  });
  websocketService.connect();
}
