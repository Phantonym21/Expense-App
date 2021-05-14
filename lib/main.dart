import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'storage_utils.dart';
import 'form_input_card.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        // bottomNavigationBar: AppBar(
        //   title: Text('Navigation Bar'),
        // ),
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
    return Column(
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
