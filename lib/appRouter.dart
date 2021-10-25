import 'package:breakingbad/business/cubit/bad_breaking_cubit.dart';
import 'package:breakingbad/data/models/character.dart';
import 'package:breakingbad/data/repository/charactersRepository.dart';
import 'package:breakingbad/data/webServices/charactersWebServices.dart';
import 'package:breakingbad/presentation/screens/characterScreen.dart';
import 'package:breakingbad/presentation/screens/detailsScreen.dart';
import 'package:breakingbad/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  CharactersRepository charactersRepository;
  BadBreakingCubit badBreakingCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharacterWebServices());
    badBreakingCubit = BadBreakingCubit(charactersRepository);
  }
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => badBreakingCubit..getAllCharacters(),
            child: CharacterScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => BadBreakingCubit(charactersRepository)..getCharQuote(character.name),
                  child: DetailsScreen(
                    character: character,
                  ),
                ));
    }
  }
}
