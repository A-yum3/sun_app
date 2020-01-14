import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sun_app/database_helper.dart';


class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController _tcontroller;
  DateTime selectedDate = DateTime.now();
  final dbHelper = DatabaseHelper.instance;

  void initState() {
    super.initState();
    _tcontroller = TextEditingController();
  }

  void dispose() {
    _tcontroller.dispose();
    super.dispose();
  }

  Widget _urlformfield() {
    return TextField(
      controller: _tcontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'URL',
      ),
      // onSubmitted: ,
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  TextStyle tempstyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    fontStyle: FontStyle.italic,
  );

  void _insert(String url, DateTime date) async {
    Map<String, dynamic> row ={
      DatabaseHelper.columnurl :url,
      DatabaseHelper.columndate: date.toString(),
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Transaction',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white10,
        ),
        body: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Please Input Okazu URL', style: tempstyle),
                Padding(padding: const EdgeInsets.all(10.0),),
                _urlformfield(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                ),
                Center(child: Text("Please Select Day", style: tempstyle)),
                Padding(padding: const EdgeInsets.all(10.0),),
                RaisedButton(
                  child: Text(
                      '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
                Padding(padding: const EdgeInsets.all(20.0),),
                ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    child: RaisedButton.icon(
                      icon: Icon(
                        Icons.airline_seat_recline_normal,
                        color: Colors.white,
                        size: 70.0,
                      ),
                      label: Text("致した！",
                      style: TextStyle(
                        fontSize: 40.0
                      ),),
                      onPressed: () {
                        _insert(_tcontroller.text, selectedDate);
                        // selectedDate と _tcontrollerを受け渡して画面を閉じる
                        Navigator.of(context).pop();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                    )),
                // RaisedButton (致したボタン) (submit)
              ],
            ),
          ),
        ));
  }
}
