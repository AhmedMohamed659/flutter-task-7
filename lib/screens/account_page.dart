import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String gender = 'Male';

  Future<void> saveAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('first_name', firstNameController.text);
    await prefs.setString('last_name', lastNameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('job', jobTitleController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('gender', gender);

    Navigator.pushReplacementNamed(context, '/home');
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildFormField(firstNameController, 'First Name'),
              SizedBox(height: 15),
              buildFormField(lastNameController, 'Last Name'),
              SizedBox(height: 15),
              buildFormField(emailController, 'Email'),
              SizedBox(height: 15),
              buildFormField(jobTitleController, 'Job Title'),
              SizedBox(height: 15),
              buildFormField(addressController, 'Address'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gender',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (val) => setState(() => gender = val!),
                  ),
                  Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (val) => setState(() => gender = val!),
                  ),
                  Text('Female'),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Save Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(label),
      validator: (val) => val!.isEmpty ? 'Required' : null,
    );
  }
}