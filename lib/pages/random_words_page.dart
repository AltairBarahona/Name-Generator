import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/*This is an excercise from Flutter documentation, first app
Startup Name Genetaror.
I wrote comments to be able to understand the code and it´s logic
Altair Barahona
*/

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  List _suggestions = <WordPair>[]; //list for save pairs of words
  final _biggerFont = TextStyle(fontSize: 18); //increase font size in ListTile
  final _saved = <WordPair>{}; //Set, the values can only be contained once

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Names generator - Altair"),
        actions: [
          IconButton(
            //IconButton to be able to have "onPressed" method
            icon: Icon(Icons.list), //Icon of the button
            onPressed:
                _pushSaved, //Method launch on pressed, will show a page with saved items
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      //creates widgets on demand, usefull because the pairs of words can be "infinite"
      padding: EdgeInsets.all(16), //Space inside the widget
      itemBuilder: (context, index) {
        //
        if (index.isOdd) return Divider(); //return a "Line" between ListTiles
        /*index of itemBuilder is te number of elements contained in the return.
        _suggestions is a list of WordPair, that means when the index has a value of
        0 or 1, the "WordPair" used in the return will be the element #0 in that list.
        where index has a value of 2 or 3, the "WordPair" used in the return will be
        the element #1 in that list (in _suggestions).
        For this reason y have to divide index by 2 and round over it to int and then use
        this new value because is there a problem with the number of values that
        itemBuilder tries to use to build return widgets, and values in
        suggestions list.

        If there are 12 words values in _suggestions, really only are 6 WordPair
        values but itemBuilder tries to build 12 widgets and the list _suggestions
        only have 6 values. 
        */
        final i = index ~/ 2;
        /*At the beginning 0>=0 is true, add 10 words (5 WordPairs)
        */
        if (i >= _suggestions.length) {
          _suggestions
              .addAll(generateWordPairs().take(10)); //adds other 10 word pairs
        }
        return _buildRow(_suggestions[i]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair); //very if pair is already saved
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      /*Using a operator "?" to set one or other property to the widget.
      It´s useful to indicates to user if he has already save or not an item
      with the color of the favorite Icons */
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        /*setState "refresh" the UI*/
        setState(() {
          if (alreadySaved) {
            //if an item is alreade saved
            _saved.remove(pair); //remove from _saved list
          } else {
            _saved.add(pair); //if not, add it to _saved list
          }
        });
      },
    );
  }

  void _pushSaved() {
    //Push in the routes "stack" a new page
    //context is necessary to know the tree widgets
    //MateriaPageRoute gives at te appBar, a "back Icons" that works
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        /*For list type vars, we have .map method. This method returns an iterable
        wich contains one widget for each element in the list.*/
        final tiles = _saved.map(
          (WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: _biggerFont),
            );
          },
        );
        //Add Dividers between ListTiles
        /*It´s necessary to cast iterable to list because we will use a ListView
        to display items and ListView recibes a list of items as it children*/
        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text("Saved"),
          ),
          body: ListView(children: divided),
        );
      },
    ));
  }
}
