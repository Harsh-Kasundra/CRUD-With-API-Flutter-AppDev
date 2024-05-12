import 'package:api_database/mainapifile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserForm extends StatefulWidget {
  final Map<String, dynamic>? map;

  const UserForm({super.key, required this.map});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.map != null) {
      _usernameController.text = widget.map!['name'];
      _emailController.text = widget.map!['email'];
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Entry"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Username"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "E-mail"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (widget.map == null) {
                  await insertRecord();
                  Navigator.of(context).pop(true);
                } else {
                  await updateRecord();
                  Navigator.of(context).pop(true);
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }

  Future<void> insertRecord() async {
    Map<String, dynamic> map = {};
    map["name"] = _usernameController.text.toString();
    map["email"] = _emailController.text.toString();
    print(map);
    await MainApiFile().insertUser(map);
  }

  Future<void> updateRecord() async {
    Map<String, dynamic> map = {};
    map["name"] = _usernameController.text.toString();
    map["email"] = _emailController.text.toString();
    print(map);
    await MainApiFile().updateUser(updatedUser: map, id: widget.map!['id']);
  }
}
