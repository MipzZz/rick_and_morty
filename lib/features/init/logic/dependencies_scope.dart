import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/init/model/dependencies_container.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    required super.child,
    required this.dependencies,
    super.key,
  });

  /// Container with dependencies.
  final DependenciesContainer dependencies;

  /// Get the dependencies from the [context].
  static DependenciesContainer of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<DependenciesScope>()?.dependencies ??
      (throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $DependenciesContainer of the exact type',
        'out_of_scope',
      ));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<DependenciesContainer>('dependencies', dependencies),
    );
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
