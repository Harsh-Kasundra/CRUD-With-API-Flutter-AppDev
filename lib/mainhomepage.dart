import 'package:api_database/mainapifile.dart';
import 'package:api_database/userform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Display"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return UserForm(map: null);
                  },
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(CupertinoIcons.add_circled),
            color: Colors.black,
          )
        ],
      ),
      body: FutureBuilder(
        future: MainApiFile().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0.5,
                  color: Colors.lightGreenAccent,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  borderOnForeground: false,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index]['name'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )),
                      IconButton(
                          onPressed: () async {
                            await MainApiFile()
                                .deleteUser(snapshot.data![index]['id']);
                            setState(() {});
                          },
                          icon: Icon(CupertinoIcons.delete)),
                      IconButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserForm(map: snapshot.data![index]),
                                )).then((value) {
                              setState(() {});
                            });
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
