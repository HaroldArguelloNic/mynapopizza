  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/models/usuario.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<bool> agregarUsuario(Usuario usuario) async {
  try {
    // Intenta agregar el usuario a la colección de Firestore
    await _db.collection('usuarios').add(usuario.toMap());
    // Si se completa correctamente, devuelve true
    return true;
  } catch (e) {
    // Si ocurre un error, imprime el mensaje de error
    print('Error al agregar usuario: $e');
    // Devuelve false para indicar que no se pudo agregar el usuario
    return false;
  }
}

  Future<void> agregarPizzaFavorita(String userUid, String pizzaUid) async {
    try {
      // Actualiza el documento del usuario para agregar la pizza a la lista de favoritos
      await _db.collection('usuarios').doc(userUid).update({
        'favoritePizzas': FieldValue.arrayUnion([pizzaUid]),
      });
    } catch (e) {
      print('Error al agregar pizza a favoritos: $e');
      throw e;
    }
  }



  // Función para obtener los UIDs de las pizzas favoritas de un usuario
  Future<List<String>> obtenerPizzasFavoritas(String uidUsuario) async {
    try {
      List<String> favoritas = [];
      DocumentSnapshot usuarioDoc = await FirebaseFirestore.instance.collection('usuarios').doc(uidUsuario).get();

      if (usuarioDoc.exists) {
        // Verificar si el campo 'favoritePizzas' existe y es una lista de strings
        var userData = usuarioDoc.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('favoritePizzas')) {
          var favoritasData = userData['favoritePizzas'];

          if (favoritasData is List) {
            favoritas = List<String>.from(favoritasData.cast<String>());
          } else {
            print('El campo favoritePizzas no es una lista válida.');
          }
        } else {
          print('El usuario no tiene pizzas favoritas.');
        }
      } else {
        print('El usuario con UID $uidUsuario no existe.');
      }

      return favoritas;
    } catch (e) {
      print('Error al obtener las pizzas favoritas: $e');
      return [];
    }
  }