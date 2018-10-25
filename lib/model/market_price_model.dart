import 'package:meta/meta.dart';

class MarketPriceModel {
  MarketPriceModel(
      {@required this.maxPrice,
        @required this.minPrice,
        @required this.averagePrice,
        @required this.medianPrice,
        @required this.targetSiteUrl});
  final int maxPrice;
  final int minPrice;
  final int averagePrice;
  final int medianPrice;
  final String targetSiteUrl;
}