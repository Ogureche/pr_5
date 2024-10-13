import 'package:flutter/material.dart';
import 'package:pr_5/models/note.dart';
import 'package:pr_5/components/note_page.dart';

class FavPage extends StatelessWidget {
  final List<Note> favorites;
  final Function(Note) onOpenNote;
  final Function(Note) onRemoveFromFavorites;

  const FavPage({
    Key? key,
    required this.favorites,
    required this.onOpenNote,
    required this.onRemoveFromFavorites,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favorites.isEmpty
          ? const Center(child: Text('Нет товаров в избранном'))
          : Padding(
        padding: const EdgeInsets.all(0.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final note = favorites[index];
            return NotePage(
              note: note,
              onTap: () => onOpenNote(note),
              onToggleFavorite: () {
                onRemoveFromFavorites(note); // Удаляем из избранного
              },
            );
          },
        ),
      ),
    );
  }
}