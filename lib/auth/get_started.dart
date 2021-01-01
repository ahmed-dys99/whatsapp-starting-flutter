import 'package:flutter/material.dart';
import 'package:whatsapp/auth/phone_number.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.43,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/getting_started.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 55,
                        height: 55,
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 28,
                        alignment: Alignment.topCenter,
                        child: Text(
                          'whatsapp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 0.8,
                            fontFamily: 'Objectivity',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Simple. Secure.\nReliable messaging.',
                          style: TextStyle(
                            color: Color.fromRGBO(98, 119, 140, 0.075),
                            fontFamily: 'Objectivity',
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: false,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Simple. Secure.\nReliable messaging.',
                          style: TextStyle(
                            color: Color.fromRGBO(98, 119, 140, 1),
                            fontFamily: 'Objectivity',
                            fontSize: 22,
                            height: 1.23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(40),
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 18, bottom: 18),
                      child: Text('Get started', style: TextStyle(color: Colors.white, fontSize: 16)),
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProvidePhone()));
                      },
                      color: Color.fromRGBO(22, 209, 115, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    ),
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
