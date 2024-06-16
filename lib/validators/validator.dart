class Validators {
// Email validation
static String? emailValidator(String? value){
  if(value!.isEmpty) {
    return 'El email es requerido';
  }
  if(!RegExp(r'^[\w\.-]+@[w-]+\.\w{2,3}(\.\w{2,3})?$').hasMatch(value)){
    return 'favor ingrese un email valido';
  }
  return null;
}
  // password validation
  static String? passwordValidator(String? value){
    if(value!.isEmpty) {
      return 'El password es requerido requerido';
  }
    if(value.length < 6) {
      return 'la contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  //email o usuario
  static String? emailOrUser(String? value) {
    if(value!.isEmpty) {
      return 'El email o usuario es requerido';
    }
    // no se pueden dejar espacios vacios
    if(value.contains(' ')) {
      return 'el email o usuario no puede tener espacios';
    }
    return null;
  }
  //username
  static String? validateUserName(String? value){
    if(value!.isEmpty){
      return 'El usurio es requerido';
    }
    // no se pueden dejar espacios vacios
    if(value.contains(' ')) {
      return 'El usuario no puede tener espacios';
    }
    return null;
  }

  static String? regDayValidator(value){
    if(value == null || value.isEmpty) {
      return 'Ingrese la fecha de registo';
    }
    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if(!dateRegex.hasMatch(value)){
      return 'Ingrese una fecha valida';
    }
    final parts = value.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if(day == null || month == null || year == null){
      return 'Ingrese una fecha valida en formato DD/MM/AAAA';
    }
    if(day < 1 || day >31) {
      return 'El día debe estar entre 1 y 31';
    }
    if(month < 1 || month >12) {
      return 'El día debe estar entre 1 y 12';
    }
    if(year < 1900 || year > DateTime.now().year) {
      return 'Ingrese un año valido';
    }

    return null;
  }

}