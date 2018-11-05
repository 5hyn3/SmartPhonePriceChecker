import 'dart:async';
import 'package:flutter_scraping/model/scrape_result_per_cell_model.dart';
import 'package:html/dom.dart';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:flutter_scraping/repository/scrape_repository.dart';

class MusbiScrapeRepository extends ScrapeRepository {
  String siteUrl() => 'https://www.musbi.net/keitai/search.php?com=asearch&category_id=116107&pdcondition_id=18&searchword_txt=';
  Future<ScrapeResultModel> getScrapeResult(String name) async {
    Document document = await getDocument(name);
    final ret = ScrapeResultModel(cells: List<ScrapeResultPerCellModel>(), targetSiteUrl: siteUrl() + name);
    await for (Element element in tagStream(document, 'item')) {
      List<Element> priceElements;
      priceElements = element.getElementsByClassName('price');

      int price;

      try {
        price = elementToInt(priceElements.first);
      } catch (e) {
        continue;
      }

      final value = ScrapeResultPerCellModel(
          stock: 1,
          maxPrice: price,
          minPrice: price
      );
      ret.cells.add(value);
    }
    return ret;
  }
}