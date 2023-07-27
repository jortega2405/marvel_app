

import 'package:flutter/material.dart';
import 'package:marvel_app/providers/character_provider.dart';
import 'package:marvel_app/search/search_delegate.dart';
import 'package:marvel_app/widgets/card_swiper.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CharacterProvider>(context, listen: false).fetchCharacters();
  }
  @override
  Widget build(BuildContext context) {
    final characterProvider= Provider.of<CharacterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CharacterSearchDelegate());
              },
              icon: const Icon(Icons.search_outlined)),
        ],
      ),
      body: Center(
        child: CardSwiperWidget(
              characters: characterProvider.characters,
        ),
      )
    );
  }
}