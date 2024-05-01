// @date 28/04/2024
// @project sandbox
// @author rober

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/view/view_widget.dart';
import '/src/view_model/view_model.dart';

/// A widget meant to bind a [ViewModel] to a [ViewWidget] (or [Widget])
class Binder<T extends ViewModel> extends ChangeNotifierProvider<T> {
  Binder({
    super.key,
    required super.create,
    super.child,
  }) : super(lazy: true);
}
