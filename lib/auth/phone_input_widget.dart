import 'package:flutter/material.dart';

class PhoneInputWidget extends StatefulWidget {
  final _countryCodecontroller;
  final _phoneNumberController;

  PhoneInputWidget(this._countryCodecontroller, this._phoneNumberController);

  @override
  _PhoneInputWidgetState createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget._countryCodecontroller,
            style: TextStyle(
              color: Color.fromRGBO(35, 47, 59, 1),
              fontFamily: 'Objectivity',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              focusColor: Colors.black,
              contentPadding: EdgeInsets.only(left: 5, bottom: -15),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          flex: 1,
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: widget._phoneNumberController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color.fromRGBO(35, 47, 59, 1),
              fontFamily: 'Objectivity',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.only(left: 5, bottom: -15),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          flex: 4,
        ),
      ],
    );
  }
}
