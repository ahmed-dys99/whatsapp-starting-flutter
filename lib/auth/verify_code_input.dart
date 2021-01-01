import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class VerifyCode extends StatefulWidget {
  final _smsCode;

  VerifyCode(this._smsCode);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final List<TextEditingController> _controllers = <TextEditingController>[];
  final List<FocusNode> _focusNodes = <FocusNode>[];
  List<String> _code = [];

  CountdownTimerController countdownController;

  @override
  void initState() {
    for (var i = 0; i < 6; i++) {
      _controllers.add(new TextEditingController());
      _focusNodes.add(new FocusNode());
      _code.add(' ');
    }
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    countdownController = CountdownTimerController(endTime: endTime, onEnd: () {});
    super.initState();
  }

  void nodeNext(int i) {
    if (i < 5) {
      _focusNodes[i + 1].requestFocus();
    } else {
      _focusNodes[i].unfocus();
    }
  }

  void nodePrev(int i) {
    if (i > 0) {
      _focusNodes[i - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 6; i++)
              Container(
                width: 40,
                margin: EdgeInsets.only(right: 10),
                child: TextField(
                  key: ValueKey(i),
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color.fromRGBO(35, 47, 59, 1),
                    fontFamily: 'Objectivity',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    contentPadding: EdgeInsets.only(bottom: -15),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                  onChanged: (value) {
                    if (value == '') {
                      _code[i] = '';
                      nodePrev(i);
                    } else {
                      if (value.length == 2) {
                        if (value[0] != _code[i]) {
                          _code[i] = value[0];
                        } else {
                          _code[i] = value[1];
                        }
                        _controllers[i].text = _code[i];
                      } else {
                        _code[i] = value;
                      }
                      nodeNext(i);
                    }
                    widget._smsCode(_code.join());
                  },
                ),
              ),
          ],
        ),
        SizedBox(height: 50),
        CountdownTimer(
          controller: countdownController,
          widgetBuilder: (_, time) {
            return Text(
              time == null ? "Time left to enter code: 0:00" : "Time left to enter code: 0:" + time.sec.toString(),
              style: TextStyle(
                color: Color.fromRGBO(98, 119, 140, 1),
                fontFamily: 'Objectivity',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            );
          },
        ),
      ],
    );
  }
}
