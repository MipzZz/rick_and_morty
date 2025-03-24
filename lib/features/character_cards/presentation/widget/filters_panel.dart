import 'package:flutter/material.dart';

/// {@template FiltersPanel.class}
/// FiltersPanel widget.
/// {@endtemplate}
class FiltersPanel extends StatelessWidget {
  /// {@macro FiltersPanel.class}
  const FiltersPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        FilterChip(label: Text('Фильтр 1'), onSelected: (_) {}),
        FilterChip(label: Text('Фильтр 2'), onSelected: (_) {}),
        FilterChip(label: Text('Фильтр 3'), onSelected: (_) {}),
      ],
    );
  }
}
