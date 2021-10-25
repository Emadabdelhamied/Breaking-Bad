import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/business/cubit/bad_breaking_cubit.dart';
import 'package:breakingbad/data/models/character.dart';
import 'package:breakingbad/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;
  DetailsScreen({@required this.character});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          title: 'Jobs : ',
                          value: character.occupation.join(' / ')),
                      myDivider(endIndent: 250),
                      characterInfo(
                          title: 'Appeared In : ', value: character.category),
                      myDivider(endIndent: 200),
                      characterInfo(
                          title: 'Seasons : ',
                          value: character.breakingBadAppearance.join(' / ')),
                      myDivider(endIndent: 220),
                      characterInfo(
                          title: 'Status : ', value: character.status),
                      myDivider(endIndent: 180),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              title: 'Better Call Saul : ',
                              value: character.betterCallSaulAppearance
                                  .join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : myDivider(endIndent: 220),
                      characterInfo(
                          title: 'Actor / Actress : ',
                          value: character.portrayed),
                      myDivider(endIndent: 270),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<BadBreakingCubit, BadBreakingState>(
                        builder: (context, state) {
                          return checkIfQuoteIsLoaded(state);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() => SliverAppBar(
        expandedHeight: 600,
        elevation: 0,
        backgroundColor: MyColors.myGrey,
        pinned: true,
        stretch: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            '${character.nickname}',
            style: TextStyle(color: MyColors.myWhite),
          ),
          centerTitle: true,
          background: Hero(
              tag: character.charId,
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
              )),
        ),
      );
  Widget characterInfo({@required String title, @required String value}) =>
      RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myWhite),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: MyColors.myWhite, fontSize: 16),
            ),
          ],
        ),
      );
  Widget myDivider({@required double endIndent}) => Divider(
        height: 30,
        endIndent: endIndent,
        color: MyColors.myYellow,
        thickness: 2,
      );

  Widget checkIfQuoteIsLoaded(BadBreakingState state) => state is QuoteLoaded
      ? displayRandomQuoteOrEmptyContainer(state)
      : showProgressIndicator();

  Widget displayRandomQuoteOrEmptyContainer(state) {
    var quotes = state.quote;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: MyColors.myWhite, shadows: [
            Shadow(blurRadius: 7, color: MyColors.myYellow, offset: Offset.zero)
          ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget showProgressIndicator() => Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.myYellow)),
      );
}
