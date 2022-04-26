import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeWidget extends StatefulWidget {
  const CodeWidget({Key? key, required this.myController}) : super(key: key);

  final TextEditingController myController;

  @override
  State<CodeWidget> createState() => _CodeWidgetState();
}

class _CodeWidgetState extends State<CodeWidget> {
  onChanged(text) {
    if (text.length == 1) {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 69,
      width: 47,
      child: TextFormField(
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        obscureText: true,
        controller: widget.myController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
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
    );
  }
}
