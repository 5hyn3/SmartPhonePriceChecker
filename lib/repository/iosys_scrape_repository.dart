import 'dart:async';
import 'package:flutter_scraping/model/scrape_result_per_cell_model.dart';
import 'package:html/dom.dart';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:flutter_scraping/repository/scrape_repository.dart';

class IosysScrapeRepository extends ScrapeRepository {
  String siteUrl() => 'https://iosys.co.jp/items?t=g&q=';

  Future<ScrapeResultModel> getScrapeResult(String name) async {
    Document document = await getDocument(name);
    final ret = ScrapeResultModel(
        cells: List<ScrapeResultPerCellModel>(),
        targetSiteUrl: siteUrl() + name);
    await for (Element element in tagStream(document, 'item-list')) {
      final stockElements = element.getElementsByClassName('stock');
      final maxElements = element.getElementsByClassName('max');
      final minElements = element.getElementsByClassName('min');

      final stock = elementToInt(stockElements.first);
      final maxPrice = elementToInt(maxElements.first);
      var minPrice = maxPrice;
      if (minElements.isNotEmpty) {
        minPrice = elementToInt(minElements.first);
      }

      final value = ScrapeResultPerCellModel(
          stock: stock, maxPrice: maxPrice, minPrice: minPrice);
      ret.cells.add(value);
    }
    return ret;
  }
}
