// @date 28/04/2024
// @project sandbox
// @author rober

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/model/model.dart';
import '/src/utils/lifecycle_utils.dart';
import '/src/view/view_widget.dart';

/// The base class for all [ViewModel]s
abstract class ViewModel<T extends Model> extends ChangeNotifier {
  final Map<Type, ViewModel> _parents = {};

  /// List of parents [ViewModel] that this [ViewModel] will listen to for changes
  Map<Type, ViewModel> get parents => Map.unmodifiable(_parents);

  /// The [BuildContext] of this [ViewModel]
  final BuildContext context;

  /// The [Model] of this [ViewModel]
  /// must be defined
  T get model;

  bool _mounted = false;

  /// Whether this [ViewModel] is still binded to a [Widget] tree
  bool get mounted => _mounted;

  ViewModel(this.context) {
    _mounted = true;
    model.addListener(update);
    init();
    LifecycleUtils.postFrame(ready);
  }

  @override
  void dispose() {
    _mounted = false;
    model.removeListener(update);
    untieAll();
    super.dispose();
  }

  /// Called during the construction of this [ViewModel]
  @protected
  @mustCallSuper
  void init() {}

  /// Called when the [ViewWidget] UI is ready
  @protected
  @mustCallSuper
  void ready() {}

  /// Used to update the [ViewWidget] UI.
  /// Should be used when there are changes that need to be reflected on the
  /// UI
  @protected
  @mustCallSuper
  void update() {
    if (_mounted) {
      notifyListeners();
    }
  }

  /// Ties another A [ViewModel] of type [K] to this B [ViewModel], meaning that
  /// B will listen to all A changes and [update]s.
  ///
  /// The A [ViewModel] should be upper in the [Widget] tree than this
  /// B [ViewModel] in order to be able to find it
  K tie<K extends ViewModel>() {
    if (_parents.containsKey(K)) {
      return _parents[K] as K;
    }
    _parents[K] = context.read<K>();
    _parents[K]?.addListener(notifyListeners);

    notifyListeners();

    return _parents[K] as K;
  }

  /// Untie a [ViewModel] of type [K] that was previously tied to this [ViewModel]
  /// via the [tie] method
  void untie<K extends ViewModel>() {
    _parents.remove(K)?.removeListener(notifyListeners);
  }

  /// Unties all [ViewModel]s that this [ViewModel] is tied to
  void untieAll() {
    _parents.removeWhere((key, value) {
      value.removeListener(notifyListeners);
      return true;
    });
  }
}
