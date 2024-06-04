import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/register/register.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 28,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 7.0,
              bottom: 7.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter Email",
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                fillColor: Color(0xfff9f9f9),
                filled: true,
                focusColor: Color(0xfff9f9f9),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 7.0,
              bottom: 7.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your password",
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                fillColor: Color(0xfff9f9f9),
                filled: true,
                focusColor: Color(0xfff9f9f9),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off_outlined),
                  onPressed: () => {},
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 7.0,
              bottom: 7.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Color del texto
                  ),
                ),
              ),
            ),
          ),
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
                      text: ' Sign Up',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );
                        },
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
