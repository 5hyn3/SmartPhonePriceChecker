import 'dart:async';
import 'package:flutter_scraping/model/scrape_result_per_cell_model.dart';
import 'package:html/dom.dart';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:flutter_scraping/repository/scrape_repository.dart';

class SofmapScrapeRepository extends ScrapeRepository {
  String siteUrl() => 'https://www.sofmap.com/search_result.aspx?gid=UD47040000&keyword=';

  Future<ScrapeResultModel> getScrapeResult(String name) async {
    Document document = await getDocument(name);
    final ret = ScrapeResultModel(cells: List<ScrapeResultPerCellModel>(), targetSiteUrl:  siteUrl() + name);
    await for (Element element in tagStream(document, 'search-img-textbox')) {
      var priceElements = element.getElementsByClassName('tokka-price');
      if(priceElements.isEmpty) {
        priceElements = element.getElementsByClassName('normal-price');
      }
      final priceInSpan = priceElements.first.getElementsByTagName('span').first;
      final price = elementToInt(priceInSpan);

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
