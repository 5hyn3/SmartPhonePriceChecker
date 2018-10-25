import 'package:flutter/material.dart';
import 'package:flutter_scraping/screen/search_result_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key key, this.title}) : super(key: key);
  final String title;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: 'Please input smartphone name'),
                  onSubmitted: (String keyword) => pushResultPage(context),
                ),
                RaisedButton(
                  child: Text("Search"),
                  onPressed: () => pushResultPage(context),
                ),
              ]))),
    );
  }

  void pushResultPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute<Null>(
            settings: const RouteSettings(name: "/result"),
            builder: (BuildContext context) =>
                SearchResultScreen(
                  title: 'Result',
                  searchKeyWord: _controller.text,
                )));
}
