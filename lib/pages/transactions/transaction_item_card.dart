import 'package:flutter/material.dart';

import '../../utils/pallete.dart';
import '../../utils/strings.dart';
import '../../models/transaction.dart';

class TransactionItemCard extends StatelessWidget {
  final Transaction transaction;

  TransactionItemCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        child: ExpansionTile(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: transaction.productList != null
                        ? transaction.productList
                            .map((t) => Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(t.productName ?? "Unknown",
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead
                                            .copyWith(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500)),
                                    Container(
                                      width: 100,
                                      child: Text(
                                          "Mp. ${t?.mpoints}" ?? "Mp. 12345",
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: Pallete.primary)),
                                    ),
                                  ],
                                )))
                            .toList()
                        : Container(
                            child: Center(
                              child: Text(
                                'Nothing Eligible Product List.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  )),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 140,
                  child: Text(
                    transaction?.customerName ?? "Unknown",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Pallete.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: 100,
                    child: Text(
                      transaction.productList != null
                          ? "Mp. ${transaction.productList.map((m) => m.mpoints).reduce((a, b) => a + b)}"
                          : 'Mp. 0' ?? "Mp. 12345",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15,
                          color: Pallete.primary,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            leading: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Pallete.primary, width: 1.5)),
                  child: Text(transaction.productList != null
                      ? "${transaction.productList.length}"
                      : "0"),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
