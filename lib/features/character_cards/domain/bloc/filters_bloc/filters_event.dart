part of 'filters_bloc.dart';

@immutable
sealed class FiltersEvent {}

class FiltersEvent$Change extends FiltersEvent {
  final List<Filter> filters;

  FiltersEvent$Change(this.filters);
}
