import 'package:flutter/material.dart';
import 'package:flutter_scraping/viewmodel/prices_view_model.dart';
import 'package:flutter_scraping/widget/prices_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class ResultCardWidget extends StatelessWidget {
  ResultCardWidget({this.title, this.pricesViewModel});

  final String title;
  final PricesViewModel pricesViewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20.0,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: ScopedModel<PricesViewModel>(
                          model: pricesViewModel,
                          child: ScopedModelDescendant<PricesViewModel>(
                              builder: (context, child, model) {
                                if(model.marketPrice == null) {
                                  return Text("now loading");
                                } else {
                                  return PricesWidget(model.marketPrice);
                                }
                          }))),
                ])));
  }
}
