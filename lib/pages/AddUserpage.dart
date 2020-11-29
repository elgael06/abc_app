import 'package:abc_app/controllers/user.controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserPage extends StatelessWidget {
  final UserControllers userController = Get.find();

  AddUserPage() {
    Get.rawSnackbar(message: 'nuevo usuario!!!');
  }
  Future _saveUser() async {
    print('guardar');
    bool res = await userController.saveUser();
    print(res);
    if (res) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo usuario'),
        centerTitle: true,
        actions: [_buttonSave()],
      ),
      body: GetBuilder<UserControllers>(
          dispose: (_) => userController.listaUsuarios(),
          initState: (_) => userController.newUser(),
          id: 'form_user',
          builder: (_) => Container(
                  child: ListView(
                padding: EdgeInsets.only(
                  top: 30,
                ),
                children: [
                  _input('Nombre', userController.changeUser('name')),
                  _input('Email', userController.changeUser('emailid')),
                  _input('Telefono', userController.changeUser('contact')),
                  _input('Puesto', userController.changeUser('type'))
                ],
              ))),
    );
  }

  Widget _buttonSave() {
    return IconButton(
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: _saveUser);
  }

  Widget _input(String title, Function event) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        onChanged: event,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title,
        ),
      ),
    );
  }
}
