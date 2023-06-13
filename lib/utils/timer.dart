// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer {
  late ValueNotifier<int> time;
  late int _time;
  Timer? timer;
  bool get isCountdown => timer != null;

  CountdownTimer({
    required time,
  }) {
    _time = time;
    this.time = ValueNotifier(time);
  }

  start({Function? onTick, Function? onDone}) {
    if (time.value != _time) {
      time.value = _time;
    }

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        time.value--;

        if (time.value > 0) {
          onTick?.call(time.value);
        } else {
          stop();
          onDone?.call();
        }
      },
    );
  }

  stop() {
    timer?.cancel();
    timer = null;
  }
}

void main(List<String> args) {
  final a = CountdownTimer(time: 10);
  print(a.time);
}
