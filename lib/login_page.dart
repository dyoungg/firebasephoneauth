import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_futter/code_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myController = TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    String detectPhoneOrEmail(value) {
      if (value == "") {
        return "Email";
      } else if (double.tryParse(value) != null) {
        return "Phone";
      } else if (double.tryParse(value) == null) {
        return "Email";
      }
      return "";
    }

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
                        children: const [
                          Icon(
                            Icons.arrow_back_outlined,
                            size: 20,
                            color: Color(0XFF130F26),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Connect your wallet",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
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
                      "We'll send you a confirmation code",
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                keyboardType: result == "Email" ? TextInputType.emailAddress : TextInputType.number,
                controller: myController,
                onChanged: (text) {
                  setState(() {
                    var temp = result;
                    result = detectPhoneOrEmail(text);
                    if (temp != result) {
                      FocusScope.of(context).unfocus();
                    }
                    temp = result;
                  });
                },
                decoration: InputDecoration(
                  labelText: result,
                  labelStyle: const TextStyle(
                    height: 4,
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Phone number or Email",
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color(0XFFECECEC),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0XFFECECEC),
                    ),
                  ),
                ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CodePage(
                                mobile: myController.text,
                              )),
                    );
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
                    TextSpan(text: 'By signing up I agree to Zëdfi’s '),
                    TextSpan(text: 'Privacy Policy ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'and '),
                    TextSpan(text: 'Terms of Use ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'and allow Zedfi to use your information for future '),
                    TextSpan(text: 'Marketing purposes.', style: TextStyle(fontWeight: FontWeight.bold)),
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
