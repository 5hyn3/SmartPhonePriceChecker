import 'package:meta/meta.dart';

class ScrapeResultPerCellModel {
  ScrapeResultPerCellModel({@required this.stock, this.maxPrice, this.minPrice});
  final int stock;
  final int maxPrice;
  final int minPrice;
  int get price => (maxPrice + minPrice) ~/ 2;
}
