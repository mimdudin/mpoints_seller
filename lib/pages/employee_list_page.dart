import 'package:flutter/material.dart';

import '../utils/pallete.dart';
import '../utils/my_icons.dart';

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Employees',
          style: TextStyle(color: Pallete.primary),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Pallete.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Employees List:',
                style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 16,
                    color: Pallete.primary,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                 Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lionel Messi',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('PIN Number:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontSize: 15)),
                                        SizedBox(width: 20),
                                Text('2245',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16,
                                            color: Pallete.primary)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: Icon(LineAwesomeIcons.userAdd),
        backgroundColor: Pallete.primary,
        label: Text('New Employee'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: BottomAppBar(
      //   child: new Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.menu),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.search),
      //         onPressed: () {},
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
