import 'package:flutter/material.dart';
import 'package:flutter_scraping/repository/geo_mobile_scrape_repository.dart';
import 'package:flutter_scraping/repository/iosys_scrape_repository.dart';
import 'package:flutter_scraping/repository/janpara_scrape_repository.dart';
import 'package:flutter_scraping/repository/sofmap_scrape_repository.dart';
import 'package:flutter_scraping/viewmodel/prices_view_model.dart';
import 'package:flutter_scraping/widget/result_card_widget.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({Key key, this.title, @required this.searchKeyWord})
      : super(key: key);
  final String searchKeyWord;
  final String title;

  @override
  Widget build(BuildContext context) {

    final iosysPricesViewModel = PricesViewModel(
        target: searchKeyWord, repository: IosysScrapeRepository());
    final janparaPricesViewModel = PricesViewModel(
        target: searchKeyWord, repository: JanparaScrapeRepository());
    final sofmapPricesViewModel = PricesViewModel(
        target: searchKeyWord, repository: SofmapScrapeRepository());
    final geoMobilePricesViewModel = PricesViewModel(
        target: searchKeyWord, repository: GeoMobileScrapeRepository());

    iosysPricesViewModel.calcPriceModel();
    janparaPricesViewModel.calcPriceModel();
    sofmapPricesViewModel.calcPriceModel();
    geoMobilePricesViewModel.calcPriceModel();

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ResultCardWidget(
                title: "Iosys", pricesViewModel: iosysPricesViewModel),
            ResultCardWidget(
                title: "janpara", pricesViewModel: janparaPricesViewModel),
            ResultCardWidget(
                title: "sofmap", pricesViewModel: sofmapPricesViewModel),
            ResultCardWidget(
                title: "GeoMobile", pricesViewModel: geoMobilePricesViewModel)
          ],
        ));
  }
}