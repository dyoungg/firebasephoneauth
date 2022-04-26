import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_futter/code_widget.dart';

class CodePage extends StatefulWidget {
  CodePage({Key? key, required this.mobile}) : super(key: key);

  final String mobile;

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final code1 = TextEditingController();
  final code2 = TextEditingController();
  final code3 = TextEditingController();
  final code4 = TextEditingController();
  final code5 = TextEditingController();
  final code6 = TextEditingController();

  var result = "";
  var _verificationId;

  Future registerUser(String mobile) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: "+$mobile",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {},
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
      },
      codeSent: (verificationId, [forceResendingToken]) async {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future confirmed() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: result);

    await _auth.signInWithCredential(credential).then((value) {
      final snackBar = SnackBar(
        content: const Text('Successfully Signed In'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((e) {
      final snackBar = SnackBar(
        content: const Text('daflkjsdjklf'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    registerUser(
      widget.mobile,
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight * 0.15),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_outlined),
                            iconSize: 20,
                            color: const Color(0XFF130F26),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            "We’ve sent you a code",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Enter the confirmation code below",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 29.0, right: 19.0, bottom: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CodeWidget(myController: code1),
                  CodeWidget(myController: code2),
                  CodeWidget(myController: code3),
                  CodeWidget(myController: code4),
                  CodeWidget(myController: code5),
                  CodeWidget(myController: code6),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 51,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    primary: const Color(0XFFC5FF29),
                    elevation: 0,
                  ),
                  onPressed: () {
                    result = code1.text + code2.text + code3.text + code4.text + code5.text + code6.text;
                    confirmed();
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 13.0,
                    color: Color.fromARGB(146, 0, 0, 0),
                  ),
                  children: [
                    TextSpan(text: 'Didn’t recieve a code? '),
                    TextSpan(text: 'Wait for 57 sec ', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
