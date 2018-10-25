import 'dart:async';
import 'package:flutter_scraping/model/scrape_result_per_cell_model.dart';
import 'package:html/dom.dart';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:flutter_scraping/repository/scrape_repository.dart';

class JanparaScrapeRepository extends ScrapeRepository {
  String siteUrl() => 'http://www.janpara.co.jp/sale/search/result/?KEYWORDS=';

  Future<ScrapeResultModel> getScrapeResult(String name) async {
    Document document = await getDocument(name);
    final ret = ScrapeResultModel(cells: List<ScrapeResultPerCellModel>(), targetSiteUrl: siteUrl() + name);
    await for (Element element in tagStream(document, 'search_item_s')) {
      final stockElements = element.getElementsByClassName('search_itemprice').first.getElementsByTagName('div').first;
      final priceElements = element.getElementsByClassName('item_amount');

      final stock = elementToInt(stockElements);
      final price = elementToInt(priceElements.first);

      final value = ScrapeResultPerCellModel(
          stock: stock,
          maxPrice: price,
          minPrice: price
      );
      ret.cells.add(value);
    }
    return ret;
  }
}
