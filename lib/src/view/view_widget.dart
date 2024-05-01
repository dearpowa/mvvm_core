// @date 28/04/2024
// @project sandbox
// @author rober

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/view_model/view_model.dart';
import '/src/widget/binder.dart';
import '/src/widget/register.dart';

/// Base class every [ViewWidget] should inherit from
abstract class ViewWidget<T extends ViewModel> extends StatefulWidget {
  const ViewWidget({
    super.key,
  });

  /// Called when this [ViewWidget] is being initialized
  @protected
  @mustCallSuper
  void init() {}

  /// Used to bind a [ViewModel] via other widgets like [Binder] and [Register]
  Widget bind(BuildContext context, Widget child);

  /// Build this [ViewWidget] with the bound [ViewModel] via the [bind] method
  Widget build(BuildContext context, T viewModel);

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and requests that this location in the tree
  /// update to display a new widget with the same [runtimeType] and
  /// [Widget.key], the framework will update the [widget] property of this
  /// [State] object to refer to the new widget and then call this method
  /// with the previous widget as an argument.
  ///
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which
  /// means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.didUpdateWidget(oldWidget)`.
  ///
  /// _See the discussion at [Element.rebuild] for more information on when this
  /// method is called._
  @protected
  @mustCallSuper
  void didUpdateView(covariant ViewWidget<T> oldView) {}

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an
  /// [InheritedWidget] that later changed, the framework would call this
  /// method to notify this object about the change.
  ///
  /// This method is also called immediately after [initState]. It is safe to
  /// call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
  ///
  /// Subclasses rarely override this method because the framework always
  /// calls [build] after a dependency changes. Some subclasses do override
  /// this method because they need to do some expensive work (e.g., network
  /// fetches) when their dependencies change, and that work would be too
  /// expensive to do for every build.
  @protected
  @mustCallSuper
  void didChangeDependencies() {}

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  ///
  /// In most cases, after a [State] object has been deactivated, it is _not_
  /// reinserted into the tree, and its [dispose] method will be called to
  /// signal that it is ready to be garbage collected.
  ///
  /// In some cases, however, after a [State] object has been deactivated, the
  /// framework will reinsert it into another part of the tree (e.g., if the
  /// subtree containing this [State] object is grafted from one location in
  /// the tree to another due to the use of a [GlobalKey]). If that happens,
  /// the framework will call [activate] to give the [State] object a chance to
  /// reacquire any resources that it released in [deactivate]. It will then
  /// also call [build] to give the object a chance to adapt to its new
  /// location in the tree. If the framework does reinsert this subtree, it
  /// will do so before the end of the animation frame in which the subtree was
  /// removed from the tree. For this reason, [State] objects can defer
  /// releasing most resources until the framework calls their [dispose] method.
  ///
  /// The framework does not call this method the first time a [State] object
  /// is inserted into the tree. Instead, the framework calls [initState] in
  /// that situation.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  ///
  /// See also:
  ///
  ///  * [Element.activate], the corresponding method when an element
  ///    transitions from the "inactive" to the "active" lifecycle state.
  @protected
  @mustCallSuper
  void activate() {}

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  ///
  /// In most cases, after a [State] object has been deactivated, it is _not_
  /// reinserted into the tree, and its [dispose] method will be called to
  /// signal that it is ready to be garbage collected.
  ///
  /// In some cases, however, after a [State] object has been deactivated, the
  /// framework will reinsert it into another part of the tree (e.g., if the
  /// subtree containing this [State] object is grafted from one location in
  /// the tree to another due to the use of a [GlobalKey]). If that happens,
  /// the framework will call [activate] to give the [State] object a chance to
  /// reacquire any resources that it released in [deactivate]. It will then
  /// also call [build] to give the object a chance to adapt to its new
  /// location in the tree. If the framework does reinsert this subtree, it
  /// will do so before the end of the animation frame in which the subtree was
  /// removed from the tree. For this reason, [State] objects can defer
  /// releasing most resources until the framework calls their [dispose] method.
  ///
  /// The framework does not call this method the first time a [State] object
  /// is inserted into the tree. Instead, the framework calls [initState] in
  /// that situation.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  ///
  /// See also:
  ///
  ///  * [Element.activate], the corresponding method when an element
  ///    transitions from the "inactive" to the "active" lifecycle state.
  @protected
  @mustCallSuper
  void deactivate() {}

  /// Called when this object is removed from the tree permanently.
  ///
  /// The framework calls this method when this [State] object will never
  /// build again. After the framework calls [dispose], the [State] object is
  /// considered unmounted and the [mounted] property is false. It is an error
  /// to call [setState] at this point. This stage of the lifecycle is terminal:
  /// there is no way to remount a [State] object that has been disposed.
  ///
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.dispose()`.
  ///
  /// ## Application shutdown
  ///
  /// This method is _not_ invoked when the application shuts down, because
  /// there is no way to predict when that will happen. For example, a user's
  /// battery could catch fire, or the user could drop the device into a
  /// swimming pool, or the operating system could unilaterally terminate the
  /// application process due to memory pressure.
  ///
  /// Applications are responsible for ensuring that they are well-behaved
  /// even in the face of a rapid unscheduled termination.
  ///
  /// To artificially cause the entire widget tree to be disposed, consider
  /// calling [runApp] with a widget such as [SizedBox.shrink].
  ///
  /// To listen for platform shutdown messages (and other lifecycle changes),
  /// consider the [AppLifecycleListener] API.
  ///
  /// See also:
  ///
  ///  * [deactivate], which is called prior to [dispose].
  @protected
  @mustCallSuper
  void dispose() {}

  @override
  ViewState<T> createState() => ViewState();
}

class ViewState<T extends ViewModel> extends State<ViewWidget<T>> {
  @override
  void initState() {
    widget.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.bind(
        context,
        Consumer<T>(
          builder: (
            context,
            value,
            child,
          ) =>
              widget.build(
            context,
            value,
          ),
        ),
      );

  @override
  void didUpdateWidget(covariant ViewWidget<T> oldWidget) {
    widget.didUpdateView(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    widget.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void activate() {
    widget.activate();
    super.activate();
  }

  @override
  void deactivate() {
    widget.deactivate();
    super.deactivate();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}
