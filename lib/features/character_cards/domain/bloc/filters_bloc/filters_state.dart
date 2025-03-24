part of 'filters_bloc.dart';

@immutable
sealed class FiltersState {
  final List<Filter> filters;
  const FiltersState({required this.filters});

  const factory FiltersState.idle({required List<Filter> filters}) = FiltersState$Idle;
}

final class FiltersState$Idle extends FiltersState {
  const FiltersState$Idle({required super.filters});
}
