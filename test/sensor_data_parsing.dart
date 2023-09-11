import 'dart:convert';
import 'dart:io';

import 'package:simple_graph_viewer/src/entities/sensor_data.dart';

void main() {}

void readSensorDataFromJSONTest() async {
  var response = await _readSensorDataSingle();
  var sensorData = SensorData.fromJson(response);
  print(sensorData);
}

Future<String> _readSensorDataSingle() async {
  final String response =
      await File("test/mock_data/sensor_data_single.json").readAsStringSync();
  return response;
}

Future<String> _readSensorDataList() async {
  final String response =
      await File("test/mock_data/sensor_data_list.json").readAsStringSync();
  return response;
}
