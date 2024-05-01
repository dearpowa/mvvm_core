// @date 29/04/2024
// @project mvvm_core
// @author rober

import 'package:flutter/scheduler.dart';

sealed class LifecycleUtils {
  static void postFrame(VoidCallback callback, {bool schedule = true}) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) => callback,
    );

    if (!schedule) return;

    SchedulerBinding.instance.scheduleFrame();
  }
}
