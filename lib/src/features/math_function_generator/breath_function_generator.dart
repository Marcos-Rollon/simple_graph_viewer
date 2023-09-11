import 'dart:async';
import "dart:math";
import 'dart:ui';

class BreathFunctionGenerator {
  final double peep; // mbar
  final double ppeak; // mbar
  final double pplateau; // mbar
  final double i;
  final double e;
  final double fr; // breath/min
  final double percentagePplateau;
  final double stepTime; // milliseconds
  final Function(double) onNewValue;

  late final double tInsp;
  late final double tExh;
  late final double breathTime;

  // Inner vars
  Timer? _timer;
  double _currentStep = 0;
  double _prevValue = 0;
  double? _startingInhalationValue;
  double? _startingExhalationValue;

  double _NOISE_FACTOR = 0.03;

  BreathFunctionGenerator(
    this.peep,
    this.ppeak,
    this.pplateau,
    this.i,
    this.e,
    this.fr,
    this.percentagePplateau,
    this.stepTime,
    this.onNewValue,
  ) {
    _calculateTime();
  }

  bool get isOn => _timer == null ? false : true;

  void _calculateTime() {
    breathTime = 60 / fr;
    tInsp = breathTime * i / (i + e);
    tExh = breathTime * e / (i + e);
  }

  void start() {
    _timer = Timer.periodic(Duration(milliseconds: stepTime.toInt()), ((timer) {
      var value = next();
      _currentStep += 1;
      onNewValue(value);
    }));
  }

  void stop() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void toggle() {
    isOn ? stop() : start();
  }

  double next() {
    var t = _currentStep * stepTime / 1000;
    // In inhalation
    if (_currentStep * stepTime <= (tInsp * 1000)) {
      // Put on null the flag of exhalation and assign if null the one of inhalation
      _startingExhalationValue = null;
      _startingInhalationValue ??= _prevValue;

      // If the p peak is reached
      if ((_prevValue - pplateau).abs() <= pplateau * 0.001) {
        _prevValue = pplateau;
        return _prevValue;
      } else {
        _prevValue =
            lerpDouble(_startingInhalationValue!, pplateau, easeOut(t))!;
        return _prevValue;
      }
    }

    // In exhalation
    if (_currentStep * stepTime > tInsp * 1000 &&
        _currentStep * stepTime <= breathTime * 1000) {
      // Put on null the flag of inhalation and assign if null the one of exhalation
      _startingInhalationValue = null;
      _startingExhalationValue ??= _prevValue;

      // If peep is reached
      if ((_prevValue - peep).abs() <= peep * 0.001) {
        _prevValue = peep;
        return _prevValue;
      } else {
        _prevValue = lerpDouble(
            _startingExhalationValue!, peep, easeOut((t - tExh).abs()))!;
        return _prevValue;
      }
    }
    // We are pass a cycle, reset
    else {
      _currentStep = 0;
      return _prevValue;
    }
  }

  double easeIn(double value) {
    return value * value;
  }

  double flip(num value) {
    return 1 - value.toDouble();
  }

  double easeOut(double value) {
    return flip(pow(flip(value), 2));
  }

  double easeInOut(value) {
    return lerpDouble(easeIn(value), easeOut(value), value)!;
  }

  double easeOutBack(value) {
    const double c1 = 0.1; //1.40158;
    const double c3 = 0.8; //c1 + 1;

    return 1 + c3 * pow(value - 1, 3) + c1 * pow(value - 1, 2);
  }

  double spring(value) {
    const a = 1.15;
    const w = 19.4;
    return -(pow(e, -value / a) * cos(value * w)) + 1;
  }

  double generateNoise() {
    return doubleInRange(Random(), -_NOISE_FACTOR, _NOISE_FACTOR);
  }

  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}
