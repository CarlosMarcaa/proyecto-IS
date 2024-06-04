import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/login/login.dart';

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
                hintText: "Enter Phone",
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
                hintText: "Enter User Type",
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
                  'Sign Up',
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
                      text: ' Sign In',
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
                                builder: (context) => const Login()),
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

// TODO: Impruve this code in order to be reusable
class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
