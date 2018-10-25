import 'package:flutter/material.dart';
import 'package:flutter_scraping/model/market_price_model.dart';
import 'package:flutter_scraping/widget/price_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PricesWidget extends StatelessWidget {
  PricesWidget(this.marketPriceModel);

  final MarketPriceModel marketPriceModel;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      PriceWidget(kind: "max", price: marketPriceModel.maxPrice.toString()),
      PriceWidget(kind: "min", price: marketPriceModel.minPrice.toString()),
      PriceWidget(
          kind: "median", price: marketPriceModel.medianPrice.toString()),
      PriceWidget(
          kind: "average", price: marketPriceModel.averagePrice.toString()),
      RaisedButton(
        child: Text("open browser"),
        onPressed: () => _launchURL(marketPriceModel.targetSiteUrl),
      )
    ]);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
