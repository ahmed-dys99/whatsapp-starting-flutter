import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/auth/phone_input_widget.dart';
import 'package:whatsapp/auth/verify_code_input.dart';

class ProvidePhone extends StatefulWidget {
  @override
  _ProvidePhoneState createState() => _ProvidePhoneState();
}

class _ProvidePhoneState extends State<ProvidePhone> {
  bool toVerify = false;
  bool isLoading = false;
  final _countryCodecontroller = TextEditingController(text: "+92");
  final _phoneNumberController = TextEditingController();
  String _smsCode;
  String verifId;

  void _setSmsCode(String code) {
    _smsCode = code;
  }

  Future<void> _submitCode() async {
    if (_smsCode.length == 6) {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifId, smsCode: _smsCode);
      await auth.signInWithCredential(credential);
      Navigator.of(context).pop();
    }
  }

  Future<void> _submitForm() async {
    if (_countryCodecontroller == null || _phoneNumberController == null) {
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    final phoneNumber = _countryCodecontroller.text.toString() + _phoneNumberController.text.toString();

    setState(() {
      isLoading = true;
    });

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int resendToken) async {
        setState(() {
          toVerify = true;
          isLoading = false;
        });
        verifId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromRGBO(35, 47, 59, 1)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/green-logo.png', width: 80, height: 80),
                    SizedBox(height: 25),
                    Text(
                      toVerify ? 'Verification' : 'Welcome to whatsapp',
                      style: TextStyle(
                        color: Color.fromRGBO(35, 47, 59, 1),
                        fontFamily: 'Objectivity',
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      toVerify
                          ? 'We have sent you an SMS with a code to the number that you provided.'
                          : 'Provide your phone number, so we can verify your identity.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromRGBO(98, 119, 140, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Objectivity',
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              if (!toVerify)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: PhoneInputWidget(_countryCodecontroller, _phoneNumberController),
                ),
              if (!toVerify)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(98, 119, 140, 1),
                        fontFamily: 'Objectivity',
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(text: 'By continuing, you are indicating that you agree to the '),
                        TextSpan(text: 'Privacy Policy', style: TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(text: ' and '),
                        TextSpan(text: 'Terms.', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              if (toVerify)
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: VerifyCode(_setSmsCode),
                ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 22),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          toVerify ? 'Verify' : 'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                  elevation: 0,
                  onPressed: toVerify ? _submitCode : _submitForm,
                  color: Color.fromRGBO(22, 209, 115, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
