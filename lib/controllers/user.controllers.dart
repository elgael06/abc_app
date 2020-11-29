import 'package:abc_app/api/usuarios.api.dart';
import 'package:abc_app/models/user.model.dart';
import 'package:get/get.dart';

class UserControllers extends GetxController {
  List<UserModel> lista = List<UserModel>().obs;
  UserModel selectUser;
  UsuariosAPI _conexionUsuarios = UsuariosAPI();

  @override
  void onClose() {
    super.onClose();
  }

  Future listaUsuarios() async {
    lista = List<UserModel>().obs;
    update(['lista_usuarios'], lista.isEmpty);
    try {
      lista = await _conexionUsuarios.getAllUsuarios();
      num total = lista.length;
      update(['lista_usuarios'], lista.isNotEmpty);
      Get.rawSnackbar(message: ' usuarios cargados $total');
    } catch (err) {
      print(err.toString());
    }
  }

  changeUser(String label) => (String value) {
        print('label $label, value $value');
        switch (label) {
          case 'name':
            selectUser.name = value;
            break;
          case 'avatar':
            selectUser.avatar = value;
            break;
          case 'contact':
            selectUser.contact = value;
            break;
          case 'emailid':
            selectUser.emailid = value;
            break;
          case 'type':
            selectUser.type = value;
            break;
        }
        update(['form_user']);
      };

  newUser() {
    selectUser = UserModel('', '', '', '', '', '');
    print(selectUser);
    update();
  }

  Future<bool> saveUser() async {
    try {
      var res = await _conexionUsuarios.createUsuario(selectUser);
      Get.rawSnackbar(
        message: res.message,
      );
      print(res.status);
      if (res.status) await listaUsuarios();
      update(['form_user']);
      return res.status;
    } catch (err) {
      Get.rawSnackbar(
        message: '$err.',
      );
      return false;
    }
  }
}
