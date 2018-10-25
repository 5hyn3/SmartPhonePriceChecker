import 'package:flutter_scraping/model/market_price_model.dart';
import 'package:flutter_scraping/model/scrape_result_model.dart';
import 'package:flutter_scraping/repository/scrape_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math';
import 'package:meta/meta.dart';

class PricesViewModel extends Model {
  PricesViewModel({@required this.target,@required this.repository});

  final String target;
  final ScrapeRepository repository;

  MarketPriceModel _marketPrice;
  MarketPriceModel get marketPrice => _marketPrice;

  set marketPrice(MarketPriceModel newMarketPrice){
    _marketPrice = newMarketPrice;
    notifyListeners();
  }

  void calcPriceModel() async {
    repository.getScrapeResult(target).then((result) {
      marketPrice = calcMarketPrice(result);
    });
  }

  MarketPriceModel calcMarketPrice(ScrapeResultModel result) {
    final maxPrice = result.cells.map((cell) => cell.maxPrice).reduce(max);
    final minPrice = result.cells.map((cell) => cell.minPrice).reduce(min);
    final allStock =
    result.cells.fold(0, (preview, element) => preview + element.stock);
    final allPrice = result.cells
        .fold(0, (preview, element) => preview + element.stock * element.price);
    final averagePrice = (allPrice / allStock).toInt();
    final prices = result.cells.map((cell) => cell.price).toList();
    final medianPrice = prices[prices.length ~/ 2];
    return MarketPriceModel(
        maxPrice: maxPrice,
        minPrice: minPrice,
        averagePrice: averagePrice,
        medianPrice: medianPrice,
        targetSiteUrl: result.targetSiteUrl);
  }
}
