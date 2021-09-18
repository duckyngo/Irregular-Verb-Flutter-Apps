import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:irregular_verbs/word.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Irregular Verbs List'),
        // ),
        body: IrregularVerbsList(),
      ),
    );
  }
}

class IrregularVerbsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _IrregularVerbsState();
  }

}

class _IrregularVerbsState extends State<IrregularVerbsList>{
  List _irrVerbList = <Word>[];    // Create a array list of type Word
  final _savedList = <String>{};      // Create a Set of type String
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    final future = loadIrregularVerbs();
    future.then((value) => {
      setState((){
        _irrVerbList = value;
      })
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("All verbs"),
        actions: [IconButton(onPressed: _pushFavorite, icon: Icon(Icons.list_rounded))],
      ),
      body: _buildWordList(),
    );
  }

  Widget _buildWordList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i){
        if (i.isOdd){
          return Divider();
        }

        final int index = i~/2;

        return _buildRow(_irrVerbList[index]);
      },
    );
  }

  Widget _buildRow(Word verb){
    final alreadySaved = _savedList.contains(verb.base);

    return ListTile(
      title: Text(
        verb.base,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){      // Note: Flutter reactive calling setState
        setState((){    // => triggers build to update UI
          if (alreadySaved) {
            _savedList.remove(verb.base);
          } else{
            _savedList.add(verb.base);
          }
        });
      },
    );
  }

  void _pushFavorite() {
    Navigator.of(context).push(

        MaterialPageRoute(builder: (BuildContext context) {
          final tiles = _savedList.map(
                  (String word){
                return ListTile(
                  title: Text(
                    word,
                    style: _biggerFont,
                  ),
                );
              }
          );

          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(tiles: tiles, context: context).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
                title: Text('Favorite Words')
            ),
            // Note: ListView can created by ListView.builder...
            // Or create by ListView(children: list..)
            body: ListView(children: divided,),
          );

        })
    );
  }


  /**
   * Load Irregular Verb list from json file
   */
  Future<List<Word>> loadIrregularVerbs() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/irregular_verbs.json");
    final jsonResult = jsonDecode(data); //latest Dart
    List<Word> posts = List<Word>.from(jsonResult.map((model)=> Word.fromJson(model)));
    return posts;
  }
}
