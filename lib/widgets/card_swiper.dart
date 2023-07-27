import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/models/response_model.dart';
import 'package:marvel_app/providers/character_provider.dart';
import 'package:provider/provider.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Result> characters;

  const CardSwiperWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (characters.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: characters.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.height * 0.4,
        itemWidth: size.width * 0.5,
        itemBuilder: (context, index) {
          final character = characters[index];
          final thumbnail = character.thumbnail!;
          final extension = thumbnail.extension.toString().toLowerCase().replaceFirst('.', '').replaceAll('extension', '');

          character.heroId = 'swiper-${character.id}';
          return GestureDetector(
            onTap: () {
               final characterProvider = Provider.of<CharacterProvider>(context, listen: false);
               characterProvider.fetchCharacterDetailsById(character.id!);
               Navigator.pushNamed(context, 'details', arguments: character);
            },
            child: Hero(
              tag: character.heroId!,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/no-image.jpg'),
                      image: NetworkImage('${thumbnail.path}/portrait_fantastic.$extension'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.7),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          character.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
