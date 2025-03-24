part of 'filters_bloc.dart';

@immutable
sealed class FiltersEvent {}

class FiltersEvent$Change extends FiltersEvent {
  final FilterEnum filter;
  final bool isSelected;

  FiltersEvent$Change({required this.filter, required this.isSelected});
}
