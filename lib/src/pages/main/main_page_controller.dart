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
  final flowInputController = LineGraphController(
    title: "Flujo (ml/s)",
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

  // PRIVATE

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
        flowInputController.addPoint(data.flowSensorInput);

        _calculateBreathData(data);
      } catch (e) {
        print(e);
      }
    });
  }

  // This should not be in this controller, it should come from the ventilator
  double _maxPressure = 0;
  double _minPressure = 10000;
  double _prevPressure = 0;
  bool previousUp = false;
  bool currentUp = false;
  void _calculateBreathData(SensorData data) {
    final averagePressure =
        data.pressureSensorInput + data.pressureSensorOutput / 2;

    // Check if the new pressure is different enough
    if ((_prevPressure - averagePressure).abs() > 2) {
      if (_prevPressure < averagePressure) {
        // We are going up
        currentUp = true;
      } else {
        // We are going down
        currentUp = false;
      }
      _prevPressure = averagePressure;
      // If we were going down and suddenly we go up, take that as a new breath
      // And only here we update the values for the ui
      if (currentUp == true && previousUp == false) {
        pplateau.value = _maxPressure;
        peep.value = _minPressure < 10000 ? _minPressure : 0;
        // Then reset
        _maxPressure = 0;
        _minPressure = 10000;
      }
      // Check for max
      if (averagePressure > _maxPressure) {
        _maxPressure = averagePressure;
      }
      // Check for min
      if (averagePressure < _minPressure) {
        _minPressure = averagePressure;
      }

      previousUp = currentUp;
    }
  }
}
