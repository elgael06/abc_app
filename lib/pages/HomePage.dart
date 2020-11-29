import 'package:abc_app/controllers/user.controllers.dart';
import 'package:abc_app/models/user.model.dart';
import 'package:abc_app/pages/AddUserpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final UserControllers userController = Get.put(UserControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista usiarios'),
          actions: [_refreshButton(userController.listaUsuarios)],
        ),
        floatingActionButton: _addUser(),
        body: RefreshIndicator(
            color: Colors.red,
            backgroundColor: Colors.blueGrey,
            onRefresh: () => userController.listaUsuarios(),
            child: GetBuilder<UserControllers>(
              dispose: (_) => userController.dispose(),
              id: 'lista_usuarios',
              initState: (_) => userController.listaUsuarios(),
              builder: (_) => ListView(
                children: _listUsuarios(_.lista),
              ),
            )));
  }

  Widget _refreshButton(Function refresh) {
    return IconButton(
        icon: Icon(
          Icons.refresh,
          size: 30,
        ),
        onPressed: refresh);
  }

  List<Widget> _listUsuarios(List<UserModel> lista) {
    return lista
        .map((e) => GestureDetector(
            onTap: () => {print(e.name)},
            child: Container(
              child: _userData(e), //Text(e.name),
              height: 100,
              color: Colors.teal[800],
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 35, top: 10),
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            )))
        .toList();
  }

  Widget _userData(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userText('Nombre', user.name),
        _userText('Email', user.emailid),
        _userText('Tel.', user.contact),
        _userText('Puesto', user.type),
      ],
    );
  }

  Widget _userText(String title, String text) {
    return Row(
      children: [
        Text(
          '$title : ',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  Widget _addUser() {
    return FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Get.to(AddUserPage(), transition: Transition.rightToLeft);
        },
        child: Icon(Icons.add));
  }
}
