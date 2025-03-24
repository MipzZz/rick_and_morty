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

  void _changeFilters(FiltersEvent$Change event, Emitter<FiltersState> emitter) =>
      emitter(FiltersState$Idle(filters: event.filters));
}
