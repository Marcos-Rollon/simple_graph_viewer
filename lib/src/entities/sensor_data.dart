import 'dart:convert';

class SensorData {
  final double flowSensorInput;
  final double flowSensorOutput;
  final double pressureSensorInput;
  final double pressureSensorOutput;
  final double valveInput;
  final double valveOutput;
  SensorData({
    required this.flowSensorInput,
    required this.flowSensorOutput,
    required this.pressureSensorInput,
    required this.pressureSensorOutput,
    required this.valveInput,
    required this.valveOutput,
  });

  SensorData copyWith({
    double? flowSensorInput,
    double? flowSensorOutput,
    double? pressureSensorInput,
    double? pressureSensorOutput,
    double? valveInput,
    double? valveOutput,
  }) {
    return SensorData(
      flowSensorInput: flowSensorInput ?? this.flowSensorInput,
      flowSensorOutput: flowSensorOutput ?? this.flowSensorOutput,
      pressureSensorInput: pressureSensorInput ?? this.pressureSensorInput,
      pressureSensorOutput: pressureSensorOutput ?? this.pressureSensorOutput,
      valveInput: valveInput ?? this.valveInput,
      valveOutput: valveOutput ?? this.valveOutput,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flowInput': flowSensorInput,
      'flowOutput': flowSensorOutput,
      'pressureInput': pressureSensorInput,
      'pressureOutput': pressureSensorOutput,
      'valveIn': valveInput,
      'valveOut': valveOutput,
    };
  }

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      flowSensorInput: (map['flowInput'] is int)
          ? map['flowInput'].toDouble()
          : map['flowInput'] as double,
      flowSensorOutput: (map['flowOutput'] is int)
          ? map['flowOutput'].toDouble()
          : map['flowOutput'] as double,
      pressureSensorInput: (map['pressureInput'] is int)
          ? map['pressureInput'].toDouble()
          : map['pressureInput'] as double,
      pressureSensorOutput: (map['pressureOutput'] is int)
          ? map['pressureOutput'].toDouble()
          : map['pressureOutput'] as double,
      valveInput: (map['valveIn'] is int)
          ? map['valveIn'].toDouble()
          : map['valveIn'] as double,
      valveOutput: (map['valveOut'] is int)
          ? map['valveOut'].toDouble()
          : map['valveOut'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorData.fromJson(String source) =>
      SensorData.fromMap(json.decode(source) as Map<String, dynamic>);

  factory SensorData.empty() => SensorData(
        flowSensorInput: 0,
        flowSensorOutput: 0,
        pressureSensorInput: 0,
        pressureSensorOutput: 0,
        valveInput: 0,
        valveOutput: 0,
      );

  @override
  String toString() {
    return 'SensorData(flowSensorInput: $flowSensorInput, flowSensorOutput: $flowSensorOutput, pressureSensorInput: $pressureSensorInput, pressureSensorOutput: $pressureSensorOutput, valveInput: $valveInput, valveOutput: $valveOutput)';
  }

  @override
  bool operator ==(covariant SensorData other) {
    if (identical(this, other)) return true;

    return other.flowSensorInput == flowSensorInput &&
        other.flowSensorOutput == flowSensorOutput &&
        other.pressureSensorInput == pressureSensorInput &&
        other.pressureSensorOutput == pressureSensorOutput &&
        other.valveInput == valveInput &&
        other.valveOutput == valveOutput;
  }

  @override
  int get hashCode {
    return flowSensorInput.hashCode ^
        flowSensorOutput.hashCode ^
        pressureSensorInput.hashCode ^
        pressureSensorOutput.hashCode ^
        valveInput.hashCode ^
        valveOutput.hashCode;
  }
}
