
import 'package:flutter/material.dart';
import 'package:marvel_app/models/response_model.dart';
import 'package:marvel_app/providers/character_provider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final characterProvider = Provider.of<CharacterProvider>(context, listen: false);
    final Result character = ModalRoute.of(context)!.settings.arguments as Result;
    characterProvider.fetchCharacterDetailsById(character.id!);
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    final Result character = ModalRoute.of(context)!.settings.arguments as Result;
    final detail = characterProvider.details[character.id!];    

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(character: character,),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // ignore: unnecessary_null_comparison
                if (character != null) ...[
                  _Description(detail: detail!),
                  _Comics(detail: detail),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Result character;
  

  const _CustomAppBar({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thumbnail = character.thumbnail!;
    final extension = thumbnail.extension.toString().toLowerCase().replaceFirst('.', '').replaceAll('extension', '');
    final title = character.name ?? 'No title available';

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          width: double.infinity,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/gifs/loading.gif'),
          image: NetworkImage('${thumbnail.path}/portrait_fantastic.$extension'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final Result detail;

  const _Description({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: detail.description == null || detail.description == ""
          ? const Text(
               'No description available',
            )
          : ListTile(title: Text( detail.description!)),
    );
  }
}

class _Comics extends StatelessWidget {
  final Result detail;

  const _Comics({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final thumbnail = detail.thumbnail!;
    final extension = thumbnail.extension.toString().toLowerCase().replaceFirst('.', '').replaceAll('extension', '');
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comics:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: detail.comics!.items!.isNotEmpty
                ? detail.comics!.items!
                    .map(
                      (comic) => ListTile(
                        title: Text(
                          comic.name ?? 'No data available',
                          style: const TextStyle(fontSize: 16),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('${thumbnail.path}/portrait_fantastic.$extension'),
                        ) 
                      ),
                    )
                    .toList()
                : [const Text('No data available')],
          ),
        ],
      ),
    );
  }
}
