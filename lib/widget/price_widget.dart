import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  PriceWidget({this.kind, this.price});

  final String kind;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(
        this.kind,
        style: TextStyle(
          fontFamily: "Roboto",
          fontSize: 16.0,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(
          "${this.price} yen",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 16.0,
          ),
        ),
      ),
    ]);
  }
}
