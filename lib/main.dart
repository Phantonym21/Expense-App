// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'storage_utils.dart';
import 'form_input_card.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
// import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
    );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 61, 89, 30),
        title: Center(
          child: Text(
            'Your Expenses',
            style: TextStyle(
              color: Color.fromRGBO(244, 180, 26, 1),
              fontFamily: 'Hallo sans',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    entryList.initData(
        'SELECT TOP 5 * FROM (SELECT * FROM entries ORDER BY id DESC)');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(244, 180, 26, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 180, 26, 1),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromRGBO(244, 180, 26, 1),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      // alignment: Alignment.center,
                      child: Text(

                        'Recent Expenses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(20, 61, 89, 30),
                          fontFamily: 'Hallo sans',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        // autofocus: true,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(20, 61, 89, 30),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListExpenseRoute()),
                          );
                        },
                        child: Center(
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(244, 180, 26, 1),
                              fontFamily: 'Hallo sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Data List
          Expanded(
            flex: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(20, 61, 89, 30),
              ),
              // child: DataTable(
              //   headingTextStyle: TextStyle(
              //     color: Color.fromRGBO(244, 180, 26, 1),
              //     fontWeight: FontWeight.bold,
              //   ),
              //   dataTextStyle: TextStyle(
              //     color: Color.fromRGBO(244, 180, 26, 1),
              //   ),
              //   showBottomBorder: true,
              //   columns: [
              //     DataColumn(label: Text('Item')),
              //     DataColumn(label: Text('Cost')),
              //     DataColumn(label: Text('Date')),
              //   ],
              //   rows: wrapDataForDisplay(entryList.listOfEntries),
              // ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(20, 61, 89, 30),
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddExpenseRoute()),
                      );
                    },
                    child: Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Color.fromRGBO(244, 180, 26, 1),
                          fontFamily: 'Hallo sans',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  List<DataRow> wrapDataForDisplay(List<ExpenseEntry> dataList) {
    return List.generate(dataList.length, (i) {
      return DataRow(cells: [
        DataCell(Text(dataList[i].item)),
        DataCell(Text(dataList[i].amt.toString())),
        DataCell(Text(DateFormat.Hm()
                .format(DateTime.parse(dataList[i].datetime)) +
            "   " +
            DateFormat.MMMd().format(DateTime.parse(dataList[i].datetime)))),
      ]);
    });
  }
}

class AddExpenseRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 61, 89, 30),
        title: Center(
          child: Text(
            'Add Expense',
            style: TextStyle(
              color: Color.fromRGBO(244, 180, 26, 1),
              fontFamily: 'Hallo sans',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: AddExpensePage(),
      ),
    );
  }
}

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  // double textBoxOpacity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(244, 180, 26, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 180, 26, 1),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 180, 26, 1),
              ),
              child: AddExpenseForm(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 180, 26, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddExpenseForm extends StatefulWidget {
  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final itemController = TextEditingController();
  final amtController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: FormInputCard(
              labelText: 'Spent on',
              controller: itemController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: FormInputCard(
              labelText: 'How much',
              controller: amtController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } else if (double.tryParse(value) == null) {
                  return 'Input is required to be a number';
                }
                return null;
              },
              fieldIcon: Icon(
                Icons.attach_money,
                color: Color.fromRGBO(20, 61, 89, 30),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: FormInputCard(
              labelText: 'Description',
              controller: descController,
              validator: (value) {
                return null;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(20, 61, 89, 30),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        int lastID = await getDatabaseSize();

                        await insertEntry(
                          ExpenseEntry(
                            id: lastID + 1,
                            datetime: DateTime.now().toString(),
                            item: itemController.text.toLowerCase(),
                            amt: double.tryParse(amtController.text),
                            desc: descController.text.toLowerCase(),
                          ),
                        );

                        print(await listEntries());

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Add Entry',
                      style: TextStyle(
                        color: Color.fromRGBO(244, 180, 26, 1),
                        fontFamily: 'Hallo sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListExpenseRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 61, 89, 30),
        title: Center(
          child: Text(
            'All Expenses',
            style: TextStyle(
              color: Color.fromRGBO(244, 180, 26, 1),
              fontFamily: 'Hallo sans',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListExpensePage(),
      ),
    );
  }
}

ExpenseEntries entryList = ExpenseEntries();

class ListExpensePage extends StatefulWidget {
  @override
  _ListExpensePageState createState() => _ListExpensePageState();
}

class _ListExpensePageState extends State<ListExpensePage> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortAmount = 0;
  bool isAscending = true;
  int sortType = sortAmount;

  String filterQuery = 'select * from entries';
  String amtDropDownValue = 'Less Than';
  final amtDropDownInputController = TextEditingController();

  @override
  void initState() {
    entryList.initData(filterQuery);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color: Color.fromRGBO(20, 61, 89, 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(9, 5, 5, 0),
                    // child: Center(
                    child: Text(
                      'Cost',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromRGBO(244, 180, 26, 1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: DropdownButton<String>(
                      value: amtDropDownValue,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromRGBO(244, 180, 26, 1),
                      ),
                      style: const TextStyle(
                        color: Color.fromRGBO(244, 180, 26, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      underline: Container(
                        height: 1,
                        color: Color.fromRGBO(244, 180, 26, 1),
                      ),
                      onChanged: (String newValue) {
                        amtDropDownValue = newValue;
                        filterQuery = _getAmtQuery(
                            amtDropDownValue, amtDropDownInputController.text);
                        initState();
                      },
                      items: <String>[
                        'Less Than',
                        'Less Than Or Equal',
                        'Greater Than',
                        'Greater Than Or Equal',
                        'Equal'
                      ].map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 15.5),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          // border: ,
                          contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(244, 180, 26, 1),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(244, 180, 26, 1),
                            ),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(244, 180, 26, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        controller: amtDropDownInputController,
                        onSubmitted: (String amount) {
                          filterQuery = _getAmtQuery(amtDropDownValue, amount);
                          initState();
                        },
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 3,
                //   child: Container(),
                // ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            child: HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: 800,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              leftSideItemBuilder: _generateFirstColumnRow,
              rightSideItemBuilder: _generateRightHandSideColumnRow,
              itemCount: entryList.listOfEntries.length,
              rowSeparatorWidget: const Divider(
                color: Color.fromRGBO(20, 61, 89, 30),
                height: 2.0,
                thickness: 2.0,
              ),
              leftHandSideColBackgroundColor: Color.fromRGBO(244, 180, 26, 1),
              rightHandSideColBackgroundColor: Color.fromRGBO(244, 180, 26, 1),
              verticalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: true,
                thickness: 4.0,
                radius: Radius.circular(5.0),
              ),
              horizontalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: true,
                thickness: 4.0,
                radius: Radius.circular(5.0),
              ),
              enablePullToRefresh: true,
              refreshIndicator: const WaterDropHeader(),
              refreshIndicatorHeight: 30,
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 200));
                _hdtRefreshController.refreshCompleted();
              },
              htdRefreshController: _hdtRefreshController,
            ),
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }

  String _getAmtQuery(String condition, String amt) {
    String sign = (condition == 'Less Than')
        ? '<'
        : ((condition == 'Less Than Or Equal')
            ? '<='
            : ((condition == 'Greater Than')
                ? '>'
                : ((condition == 'Greater Than Or Equal') ? '>=' : '=')));
    return 'select * from entries where amt' + sign + amt;
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        child: _getTitleItemWidget('Date', 100),
      ),
      _getTitleItemWidget('Item', 200),
      TextButton(
        child: _getTitleItemWidget(
            'Cost' + (sortType == sortAmount ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortAmount;
          isAscending = !isAscending;
          entryList.sortAmount(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('Description', 500),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(20, 61, 89, 30),
        ),
      ),
      width: width,
      height: 40,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    String dateFormatted = DateFormat.yMMMd()
            .format(DateTime.parse(entryList.listOfEntries[index].datetime)) +
        " " +
        DateFormat.Hm()
            .format(DateTime.parse(entryList.listOfEntries[index].datetime));
    return Container(
      child: Text(
        dateFormatted,
        style: TextStyle(
          fontSize: 17.0,
          color: Color.fromRGBO(20, 61, 89, 30),
        ),
      ),
      width: 100,
      height: 50,
      padding: EdgeInsets.fromLTRB(8, 0, 7, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            entryList.listOfEntries[index].item,
            style: TextStyle(
              fontSize: 17.0,
              color: Color.fromRGBO(20, 61, 89, 30),
            ),
          ),
          width: 200,
          height: 50,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            entryList.listOfEntries[index].amt.toString(),
            style: TextStyle(
              fontSize: 17.0,
              color: Color.fromRGBO(20, 61, 89, 30),
            ),
          ),
          width: 100,
          height: 50,
          padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            entryList.listOfEntries[index].desc,
            style: TextStyle(
              fontSize: 17.0,
              color: Color.fromRGBO(20, 61, 89, 30),
            ),
          ),
          width: 500,
          height: 50,
          padding: EdgeInsets.fromLTRB(26, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
