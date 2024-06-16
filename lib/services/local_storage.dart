import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  late Box _userBox;
 
  Future<void> init() async {
    //Inicializar Hive

    final appDocumentDirectory =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // Abrir la caja (Box) para almacenar los datos del usuario
    _userBox = await Hive.openBox('userBox');
  }

  //limpiar la caja 
  Future<void> clear() async {
    await _userBox.clear();
  }

//Guardar datos de usuario en la caja
Future<void> saveUserData(String usernameOrEmail, String password) async {
await _userBox.put('usernameOrEmail', usernameOrEmail);
await _userBox.put('contrasenia', password);
}

//Obtener datos de usuario de la caja
Future<dynamic> getUserData(String usernameOrEmail) async {
  final String contrasenia =
  _userBox.get('contrasenia', defaultValue: '' ) as String;

//devolver datos del usuario
  return {
    'uernameOrEmail': usernameOrEmail,
    'contrasenia': contrasenia
  };
}
String getEmailOrUsername() {
  return _userBox.get('usernameOrEmail', defaultValue: '') as String;
}

String getPassword() {
  return _userBox.get('contraseñia', defaultValue: '') as String;
}
//Guardar estado de inicio de sesion en la caja
Future<void> setIsSignedIn(bool IsSignedIn) async {
  await _userBox.put('is_signedin', IsSignedIn);
}
//Obtener estado de inicio de sesion de la caja
bool getIsSignedIn(){
  return _userBox.get('is_signedin', defaultValue: false) as bool;

}

Future<void> deleteIsSignedIn() async {
  await _userBox.delete('is_signedin');

}

Future<void> setIsLoggedIn(bool isLoggedIn) async {
  await _userBox.put('isLoggedIn', isLoggedIn);
}

bool getIsLoggedIn(){
  return _userBox.get('isLoggedIn', defaultValue: false) as bool;
}

Future<bool> getIsFirstTime() async {
  final bool isFirstTime =
  _userBox.get('isFirstTime', defaultValue: true);

//si es la primera vez, actualiza el valor a falso y devuelve true
  if(isFirstTime){
    await _userBox.put('isFirstTime', false);
  
  return true;
  }
  return false;
}

Future<void> savePageIndex(int index) async {
  await _userBox.put('pageIndex', index);
}
 
int getPageIndex() {
  return _userBox.get('pageIndex',defaultValue: 0) as int;
}
}