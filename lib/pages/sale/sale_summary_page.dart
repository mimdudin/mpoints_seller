import 'package:flutter/material.dart';

import '../../utils/pallete.dart';

class SaleSummaryPage extends StatefulWidget {
  @override
  _SaleSummaryPageState createState() => _SaleSummaryPageState();
}

class _SaleSummaryPageState extends State<SaleSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Points Summary',
          style: TextStyle(color: Pallete.primary),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Pallete.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Gino Furcy',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 14, color: Pallete.primary),
                ),
                Text(
                  '54545223',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 12, color: Colors.grey[400]),
                )
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 20),
            _buildPriceProduct(),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: <Widget>[
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.primary,
                                                width: 1.5)),
                                        child: Text('1'),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Product Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 20),
                              Text('Mp. 999.999.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontSize: 16,
                                          color: Pallete.primary)),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                _buildAmountField(),
                SizedBox(height: 30),
                _buildNextBtn()
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildNextBtn() {
    return Container(
      alignment: Alignment.centerRight,
      height: 40,
      width: MediaQuery.of(context).size.width / 1.3,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Text(
          'finish',
          // Strings.next,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontSize: 16, color: Colors.white),
        ),
        color: Pallete.primary,
        onPressed: () {
        
          // setState(() {
          //   if (_partNumController.text.isNotEmpty) {
          //     if (widget.model.partnerList
          //             .where(
          //                 (partner) => partner.partnerNumber == _partnerNumber)
          //             .toList()
          //             .length >
          //         0) {
          //       _validate = false;

          //       // var mpoints = int.parse(widget.purchaseAmount) * 10 / 100;
          //       // print(mpoints.toString());

          //       // var socialPoints = int.parse(widget.purchaseAmount) * 1 / 100;
          //       // print(socialPoints.toString());

          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (BuildContext context) => ClaimSummaryPage(
          //                   int.parse(widget.purchaseAmount),
          //                   // mpoints,
          //                   // socialPoints,
          //                   _partnerNumber)));
          //       _partNumController.clear();
          //     } else {
          //       _validate = false;

          //       _buildAlert(context);
          //       _partNumController.clear();
          //     }
          //   } else {
          //     _validate = true;
          //   }
          // });
        },
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      alignment: Alignment.center,
      child: TextField(
        textAlign: TextAlign.center,
        // controller: _partNumController,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.primary),
            ),
            hintText: 'enter pin',
            // Strings.enterPartNumber,
            contentPadding: EdgeInsets.symmetric(vertical: 3),
            // errorText: _validate ? "Partner Number can't be Empty." : null,
            errorStyle: TextStyle(fontSize: 14, color: Colors.redAccent[200])),
        maxLines: 1,
        keyboardType: TextInputType.number,
        onChanged: (v) {
          setState(() {
            // _partnerNumber = v;
            print(v);
          });
        },
      ),
    );
  }

  Widget _buildPriceProduct() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Rs. 999.999',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 18,
                color: Pallete.primary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1),
          Container(
            alignment: Alignment.center,
            height: 1.5,
            width: 100,
            color: Colors.grey[400],
          ),
          SizedBox(height: 2),
          Text(
            'Points Total',
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
