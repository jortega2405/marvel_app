

import 'package:flutter/material.dart';
import 'package:marvel_app/models/response_model.dart';
import 'package:marvel_app/providers/character_provider.dart';
import 'package:provider/provider.dart';


class CharacterSearchDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => 'Search Character';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear)
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _emptyContainer(){
    return const SizedBox(
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 300,
          ),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final  characterProvider = Provider.of<CharacterProvider>(context, listen: false);
    characterProvider.getSuggestionsByQuery(query);
    return StreamBuilder(
      stream: characterProvider.suggestionStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final character = snapshot.data!;
        return ListView.builder(
          itemBuilder: (context, index) {
            return  _CharacterItem(character: character[index]);
          },
          itemCount: character.length,
        ); 
      },
    );
  }
}

class _CharacterItem extends StatelessWidget {
  final Result character;
  const _CharacterItem({
    required this.character
  });

  @override
  Widget build(BuildContext context) {
    final thumbnail = character.thumbnail!;
    final extension = thumbnail.extension.toString().toLowerCase().replaceFirst('.', '').replaceAll('extension', '');
    character.heroId = 'search-${character.id}';
    return ListTile(
      leading: Hero(
        tag: character.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/no-image.jpg'),
          image: NetworkImage('${thumbnail.path}/portrait_fantastic.$extension'),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title:Text(character.name!), 
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: character);
      },
    );
  }
}