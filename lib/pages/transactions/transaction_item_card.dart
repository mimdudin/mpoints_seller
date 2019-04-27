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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  transaction?.customerName ?? "Unknown",
                  style: Theme.of(context).textTheme.subhead.copyWith(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Transactions ID #4343",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 15)),
                  Text('Mp. ${transaction?.mpoints}' ?? 'Mp. 0',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 16, color: Pallete.primary)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
