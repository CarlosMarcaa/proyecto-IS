import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create an Account",
            style: TextStyle(
              fontSize: 28,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(),
          TextField(),
          TextField(),
          TextField(),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Already have an account?',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sign In',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {})
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
