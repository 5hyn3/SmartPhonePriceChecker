import 'dart:async';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

abstract class ScrapeRepository {
  String siteUrl();
  Future<ScrapeResultModel> getScrapeResult(String name);

  Future<Document> getDocument(String name) async {
    http.Response response = await http.get(siteUrl() + name);
    return parser.parse(response.body);
  }

  Stream tagStream(Document document, String tag) async* {
    for (Element element in document.getElementsByClassName(tag)) {
      yield element;
    }
  }

  int elementToInt(Element element) => int.parse(element.text.replaceAllMapped(RegExp(r'[^0-9^\.]'), (match) {return '';}));
}
