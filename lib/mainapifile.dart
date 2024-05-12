import "dart:convert";
import "package:http/http.dart" as http;

class MainApiFile {
  Future<List> getUser() async {
    var res = await http
        .get(Uri.parse("https://65efe2deead08fa78a512135.mockapi.io/user"));
    return jsonDecode(res.body);
  }

  Future<void> deleteUser(id) async {
    await http.delete(
        Uri.parse("https://65efe2deead08fa78a512135.mockapi.io/user/" + id));
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    await http.post(
        Uri.parse("https://65efe2deead08fa78a512135.mockapi.io/user/"),
        body: jsonEncode(user),
        headers: {"Content-type": "application/json"});
  }

  Future<void> updateUser({required Map<String, dynamic> updatedUser, required id}) async {
    await http.put(
        Uri.parse("https://65efe2deead08fa78a512135.mockapi.io/user/" + id),
        body: jsonEncode(updatedUser),
        headers: {"Content-type": "application/json"});
  }
}
