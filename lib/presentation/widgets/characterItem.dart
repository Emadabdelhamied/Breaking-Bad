import 'package:breakingbad/data/models/character.dart';
import 'package:breakingbad/shared/colors.dart';
import 'package:breakingbad/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  CharacterItem(this.character);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, characterDetailsScreen,arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      height: double.infinity,
                      width: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/notLoaded.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            child: Text(
              '${character.name}',
              style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
