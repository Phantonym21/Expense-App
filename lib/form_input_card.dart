import 'package:flutter/material.dart';

class FormInputCard extends StatefulWidget {
  final String labelText;
  final controller;
  final validator;
  final Widget fieldIcon;

  FormInputCard(
      {Key key,
      @required this.labelText,
      @required this.controller,
      @required this.validator,
      @optionalTypeArgs this.fieldIcon})
      : super(key: key);

  _FormInputCardState createState() => _FormInputCardState();
}

class _FormInputCardState extends State<FormInputCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 12,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      widget.labelText,
                      style: TextStyle(
                        color: Color.fromRGBO(20, 61, 89, 30),
                        fontFamily: 'Hallo sans',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        icon: widget.fieldIcon,
                      ),
                      controller: widget.controller,
                      validator: widget.validator,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
