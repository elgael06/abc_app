import 'dart:convert';

import 'package:abc_app/models/mesageResponse.model.dart';
import 'package:abc_app/models/user.model.dart';
import 'package:http/http.dart' as http;

class UsuariosAPI {
  final _url = 'http://167.99.225.130:8000/api';

  Future<List<UserModel>> getAllUsuarios() async {
    List<UserModel> lista = [];
    http.Response data = await http.get('$_url/users');

    print('$_url/users');
    print(data.body);
    var json = jsonDecode(data.body) as List<dynamic>;
    for (var usuario in json) {
      lista.add(UserModel(
        usuario['_id'],
        usuario['type'],
        usuario['name'],
        usuario['emailid'],
        usuario['contact'],
        usuario['avatar'],
      ));
    }

    return lista;
  }

  Future<UserModel> idUsuario(String id) async {
    UserModel user;

    http.Response data = await http.get('$_url/users/$id');
    print('$_url/users/$id');
    print(data.body);
    var usuario = jsonDecode(data.body) as dynamic;

    user = UserModel(
      usuario['_id'],
      usuario['type'],
      usuario['name'],
      usuario['emailid'],
      usuario['contact'],
      usuario['avatar'],
    );
    return user;
  }

  Future<MessageResponseModel> createUsuario(UserModel usuario) async {
    var res = await http.post('$_url/users/create', body: {
      "type": usuario.type,
      "name": usuario.name,
      "emailid": usuario.emailid,
      "contact": usuario.contact,
      "avatar": usuario.avatar,
      "password": "1234"
    });
    var jsonData = jsonDecode(res.body) as dynamic;
    print(jsonData);
    bool status = jsonData['status'] != null ? jsonData['status'] : false;
    String message = jsonData['message'].toString();
    return MessageResponseModel(status, message);
  }
}
