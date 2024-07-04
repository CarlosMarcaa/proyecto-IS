import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/home_page/home_page.dart';
import 'package:repuestazo/views/register/body.dart';

class CompleteProfilePage extends StatefulWidget {
  final String userId;

  const CompleteProfilePage({super.key, required this.userId});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _workshopNameController = TextEditingController();
  final _workshopDescriptionController = TextEditingController();

  @override
  void dispose() {
    _workshopNameController.dispose();
    _workshopDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _completeProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('workshops')
            .doc(widget.userId)
            .set({
          'workshopName': _workshopNameController.text.trim(),
          'workshopDescription': _workshopDescriptionController.text.trim(),
          'userId': widget.userId, // Add the user ID to Firestore
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile completed successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error completing profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Complete Your Profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InputTextField(
                    hintText: "Enter Workshop Name",
                    controller: _workshopNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your workshop name';
                      }
                      return null;
                    },
                  ),
                  InputTextField(
                    hintText: "Enter Workshop Description",
                    controller: _workshopDescriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your workshop description';
                      }
                      return null;
                    },
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
                        onPressed: _completeProfile,
                        child: Text(
                          'Complete Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold, // Color del texto
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
