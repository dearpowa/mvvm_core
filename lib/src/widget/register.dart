// @date 28/04/2024
// @project sandbox
// @author rober

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/widget/binder.dart';

/// An utility class to bind more [Binder] to a single [child]
class Register extends StatelessWidget {
  /// The [List] of [Binder]s to whom bind the [child]
  final List<Binder> binders;

  /// The child [Widget] to attach all the [binders]
  final Widget child;

  const Register({
    super.key,
    required this.binders,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: binders,
        child: child,
      );
}
