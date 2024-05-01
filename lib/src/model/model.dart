// @date 28/04/2024
// @project sandbox
// @author rober

import 'package:flutter/widgets.dart';

import '/src/view/view_widget.dart';
import '/src/view_model/view_model.dart';

/// The base model class, should contain all data data the [ViewWidget]
/// needs to build
abstract class Model extends ChangeNotifier {
  /// Triggers rebuild of the [ViewWidget] that the [ViewModel] of this [Model]
  /// is bound to
  @mustCallSuper
  void update() => notifyListeners();
}
