import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/filters_bloc/filters_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

/// {@template FiltersPanel.class}
/// FiltersPanel widget.
/// {@endtemplate}
class FiltersPanel extends StatelessWidget {
  /// {@macro FiltersPanel.class}
  const FiltersPanel({super.key});

  void _selectFilter(BuildContext context, {required FilterEnum filter, required bool isSelected}) {
    final filtersBloc = context.read<FiltersBloc>();
    filtersBloc.add(FiltersEvent$Change(filter: filter, isSelected: isSelected));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        return Row(
          spacing: 8,
          children: List.generate(FilterEnum.values.length, (index) {
            final filter = FilterEnum.values[index];
            return FilterChip(
              label: Text(filter.title),
              selected: state.filters.contains(filter),
              onSelected: (v) => _selectFilter(context, filter: filter, isSelected: v),
            );
          }),
        );
      },
    );
  }
}
