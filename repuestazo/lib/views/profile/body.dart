import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  User? user;
  Map<String, dynamic>? userData;
  bool isEditing = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
        phoneController.text = userData?['phone'] ?? '';
        descriptionController.text = userData?['description'] ?? '';
      });
    }
  }

  Future<void> saveChanges() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'phone': phoneController.text,
        if (userData?['userType'] == 'Workshop')
          'description': descriptionController.text,
      });
      setState(() {
        userData!['phone'] = phoneController.text;
        if (userData!['userType'] == 'Workshop') {
          userData!['description'] = descriptionController.text;
        }
        isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userData!['userType'] == 'Workshop') ...[
            SizedBox(height: 16),
            _buildEditableField('Descripción', descriptionController,
                maxLines: 5),
          ],
          Text(
            'Email',
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            '   ${userData!['email']}',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          SizedBox(height: 16),
          _buildEditableField('Teléfono:', phoneController),
          SizedBox(height: 16),
          Text(
            'Tipo de Usuario',
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            '   ${userData!['userType']}',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: isEditing
                  ? saveChanges
                  : () => setState(() => isEditing = true),
              child: Text(isEditing ? 'Guardar Cambios' : 'Editar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        isEditing
            ? TextField(
                controller: controller,
                maxLines: maxLines,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: label,
                ),
              )
            : Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Text(
                  controller.text,
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ),
      ],
    );
  }
}
