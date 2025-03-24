import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/character_cards/character_cards_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/cards_grid.dart';

/// {@template CardsView.class}
/// CardsView widget.
/// {@endtemplate}
class CardsView extends StatelessWidget {
  /// {@macro CardsView.class}
  const CardsView({super.key});

  Future<void> _loadCards(BuildContext context) async {
    final characterCardsBloc = context.read<CharacterCardsBloc>()
      ..add(CharacterCardsEvent$Load());
    await characterCardsBloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _loadCards(context),
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BlocBuilder<CharacterCardsBloc, CharacterCardsState>(
          builder: (context, state) => switch (state) {
            CharacterCards$Processing() => Center(child: CircularProgressIndicator()),
            CharacterCards$Error(:final error) => Center(child: Text(error.toString())),
            CharacterCards$Idle(:final characterCards) when characterCards?.isEmpty ?? false => Text('Карточки персонажей не найдены'),
            CharacterCards$Idle(:final characterCards)  => CardsGrid(characterCards: characterCards),
          },
        ),
      ),
    );
  }
}
