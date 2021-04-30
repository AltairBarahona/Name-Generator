import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PracticePage extends StatefulWidget {
  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  List<WordPair> _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Generador de nombres - Altair"),
          actions: [
            IconButton(
              icon: Icon(Icons.list_alt),
              onPressed: () {
                _pushSaved();
              },
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (index.isOdd) return Divider();
            final i = index ~/ 2;
            if (i >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            print("ListTiles a mostrar " + i.toString());
            print("Index: " + index.toString());
            return _buildRow(_suggestions[i]);
          },
        ));
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        //
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map((WordPair pair) {
          return ListTile(
            title: Text(pair.asPascalCase, style: _biggerFont),
          );
        });

        final divider = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text("Guardados"),
          ),
          body: ListView(
            children: divider,
          ),
        );
      },
    ));
  }
}
