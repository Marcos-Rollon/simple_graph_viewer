import 'package:flutter/material.dart';
import 'package:simple_graph_viewer/src/entities/sensor_data.dart';
import 'package:simple_graph_viewer/src/features/math_function_generator/breath_function_generator.dart';
import 'package:simple_graph_viewer/src/features/websocket/websocket_service.dart';
import '../../widgets/line_graph.dart';
import "package:get/get.dart";

class MainPageController {
  final pressureGraphController = LineGraphController(
    title: "Presión (mbar)",
    minY: -10,
    color: Colors.lightBlue,
    sizeX: 1000,
  );
  final volumeGraphController = LineGraphController(
    title: "Volumen (ml)",
    maxY: 3000,
    color: Colors.redAccent,
    showMin: false,
  );
  final _websocketController = WebsocketService("http://localhost:8000");

  late final BreathFunctionGenerator generator =
      BreathFunctionGenerator(10, 32, 32, 1, 1, 20, 0.6, 10, _onGeneratorPoint);

  var pplateau = RxDouble(0);
  var peep = RxDouble(0);
  var vtidal = RxDouble(0);
  var sensorData = Rx<SensorData>(SensorData.empty());

  void togglePressureFunctionGenerator() {
    generator.toggle();
    if (!generator.isOn) {
      pressureGraphController.clear();
    }
  }

  void connectToWebsocketServer() {
    _websocketController.connect();
    _websocketController.onConnect = _onWebsocketConnect;
    _websocketController.onConnectError = (error) => print(error);
    _websocketController.onDisconnect = (reason) => print(reason);
  }

  void disconnectWebsocketServer() {
    _websocketController.disconnect();
  }

  void _onGeneratorPoint(double point) {
    pplateau.value = point;
    pressureGraphController.addPoint(point);
  }

  void _onWebsocketConnect() {
    final sensorDataStream = _websocketController.getListener("sensorData");
    sensorDataStream.value.listen((rawSensorData) {
      try {
        var data = SensorData.fromJson(rawSensorData);
        sensorData.value = data;
        pressureGraphController.addPoint(data.pressureSensorInput);
        volumeGraphController.addPoint(data.flowSensorInput);
      } catch (e) {
        print(e);
      }
    });
  }
}
