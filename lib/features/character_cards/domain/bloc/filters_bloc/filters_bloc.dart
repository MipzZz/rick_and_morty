import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

part 'filters_event.dart';

part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersState$Idle(filters: [])) {
    on<FiltersEvent>(
      (event, emitter) => switch (event) {
        FiltersEvent$Change() => _changeFilters(event, emitter),
      },
    );
  }

  void _changeFilters(FiltersEvent$Change event, Emitter<FiltersState> emitter) {
    final oldList = state.filters;
    if (event.isSelected) {
      return emitter(FiltersState$Idle(filters: [...oldList, event.filter]));
    }
    oldList.remove(event.filter);
    final List<FilterEnum> newList = List.from(oldList);
    emitter(FiltersState$Idle(filters: newList));
  }
}
