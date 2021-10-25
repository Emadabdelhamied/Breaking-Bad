import 'package:breakingbad/business/cubit/bad_breaking_cubit.dart';
import 'package:breakingbad/data/models/character.dart';
import 'package:breakingbad/presentation/widgets/characterItem.dart';
import 'package:breakingbad/presentation/widgets/offline.dart';
import 'package:breakingbad/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';

class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<Character> allCharacter;
  List<Character> searchedCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadBreakingCubit,BadBreakingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColors.myGrey,
          appBar:AppBar(
            backgroundColor: MyColors.myYellow ,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: _isSearching ? buildSearchField() : buildAppBar(),
            actions: _buildAppBarActions(),
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              final bool connected  = connectivity != ConnectivityResult.none;
              if (connected) {
                return buildBlocWidget();
              } else {
                return BuildNoInterntWidget();
              }
            },
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildShimmerLoading() => Shimmer(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            );
          },
          itemCount: 6,
        ),
        gradient: LinearGradient(
          colors: [
            Colors.grey,
            Colors.white10,
            Colors.white24,
          ],
        ),
      );

  Widget buildAppBar() => Text(
        'Characters',
        style: TextStyle(color: MyColors.myGrey, fontWeight: FontWeight.bold),
      );
  Widget buildSearchField() => TextField(
        cursorColor: MyColors.myGrey,
        controller: _searchTextController,
        decoration: InputDecoration(
          hintText: 'Find Character ...',
          hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
          border: InputBorder.none,
        ),
        style: TextStyle(color: MyColors.myGrey, fontSize: 18),
        onChanged: (searchedCharacter) {
          addSearchedForSearchedList(
            searchedCharacter: searchedCharacter,
          );
        },
      );

  void addSearchedForSearchedList({String searchedCharacter}) {
    searchedCharacters = allCharacter
        .where((character) =>
            character.name.startsWith(searchedCharacter) |
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ),
            onPressed: () {
              _searchTextController.text.isNotEmpty
                  ? _clearSearch()
                  : Navigator.pop(context);
            })
      ];
    } else {
      return [
        IconButton(
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            ),
            onPressed: () {
              ModalRoute.of(context).addLocalHistoryEntry(
                  LocalHistoryEntry(onRemove: _stopSearch));
              setState(() {
                _isSearching = true;
              });
            })
      ];
    }
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildBlocWidget() => BlocBuilder<BadBreakingCubit, BadBreakingState>(
        builder: (context, state) {
          if (state is CharacterLoaded) {
            allCharacter = state.characters;
            return buildListView();
          } else {
            return buildShimmerLoading();
          }
        },
      );

  Widget buildListView() => SingleChildScrollView(
        child: Container(
          color: MyColors.myGrey,
          child: Column(
            children: [
              buildGridView(),
            ],
          ),
        ),
      );
  Widget buildGridView() => GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CharacterItem(_searchTextController.text.isEmpty
              ? allCharacter[index]
              : searchedCharacters[index]);
        },
        itemCount: _searchTextController.text.isEmpty
            ? allCharacter.length
            : searchedCharacters.length,
      );
}
