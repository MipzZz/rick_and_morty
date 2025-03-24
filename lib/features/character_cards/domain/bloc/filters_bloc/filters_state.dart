part of 'filters_bloc.dart';

@immutable
sealed class FiltersState {
  final List<FilterEnum> filters;
  const FiltersState({required this.filters});

  const factory FiltersState.idle({required List<FilterEnum> filters}) = FiltersState$Idle;
}

final class FiltersState$Idle extends FiltersState {
  const FiltersState$Idle({required super.filters});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FiltersState$Idle && other.filters == filters;
  }

  @override
  int get hashCode => filters.hashCode;
}
