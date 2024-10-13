import 'package:flutter/material.dart';
import 'package:pr_5/components/item.dart';
import 'package:pr_5/components/note_page.dart';
import 'package:pr_5/models/note.dart';
import 'fav_page.dart';
import 'prof_page.dart';
import 'create_note_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Note> notes = [];
  List<Note> favorites = [];

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }
  void _openNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Item(note: note, onDelete: _deleteNote), // Переход на страницу детали заметки
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index); // Удаление заметки по индексу
    });
  }

  void _toggleFavorite(Note note) {
    setState(() {
      if (favorites.contains(note)) {
        favorites.remove(note);
        note.isFav = false; // Обновляем статус заметки
      } else {
        favorites.add(note);
        note.isFav= true; // Обновляем статус заметки
      }
    });
  }

  void _removeFromFavorites(Note note) {
    setState(() {
      favorites.remove(note);
      note.isFav = false; // Обновляем статус заметки
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _getCurrentPage() {
      switch (_selectedIndex) {
        case 0:
          return _buildNoteList();
        case 1:
          return FavPage(
            favorites: favorites,
            onOpenNote: _openNote, // Передаем функцию для открытия
            onRemoveFromFavorites: _removeFromFavorites, // Передаем функцию для удаления
          );
        case 2:
          return ProfPage();
        default:
          return _buildNoteList();
      }
    }
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(211, 255, 195, 175), // Здесь можно установить свой цвет фона
        ),


    child: Scaffold(
    backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('CakeTime'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateNotePage(onCreate: _addNote),
                ),
              );
            },
          ),
        ],
      ),

      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(211, 255, 153, 115),
        unselectedItemColor: const Color.fromARGB(211, 193, 193, 193),
      ),
    ),
    );
  }

  Widget _buildNoteList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return NotePage(
          note: note,
          onTap: () => _openNote(note),
          onToggleFavorite: () {
            _toggleFavorite(note);
          },
        );
      },
    );
  }
}