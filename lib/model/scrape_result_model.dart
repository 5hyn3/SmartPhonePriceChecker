import 'package:flutter_scraping/model/scrape_result_per_cell_model.dart';
import 'package:meta/meta.dart';

class ScrapeResultModel {
  ScrapeResultModel({@required this.cells, @required this.targetSiteUrl});
  final List<ScrapeResultPerCellModel> cells;
  final String targetSiteUrl;
}
