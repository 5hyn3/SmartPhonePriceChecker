import 'dart:async';
import 'package:flutter_scraping/model/scrape_result_per_cell_model.dart';
import 'package:html/dom.dart';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:flutter_scraping/repository/scrape_repository.dart';

class GeoMobileScrapeRepository extends ScrapeRepository {
  String siteUrl() => 'https://ec.geo-online.co.jp/shop/goods/search.aspx?search.y=0&style=T&search.x=0&sort=i1&keyword=';
  Future<ScrapeResultModel> getScrapeResult(String name) async {
    Document document = await getDocument(name);
    final ret = ScrapeResultModel(cells: List<ScrapeResultPerCellModel>(), targetSiteUrl: siteUrl() + name);
    await for (Element element in tagStream(document, 'StyleI_Item_')) {
      final priceElements = element.getElementsByClassName('price_');

      final price = elementToInt(priceElements.first);

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