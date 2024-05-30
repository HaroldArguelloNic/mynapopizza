import 'package:mysql_client/mysql_client.dart';
import 'package:http/http.dart' as http;

Future<void> pizzaConnect() async {

final conn =  await MySQLConnection.createConnection(
    host: "172.17.0.1",
     port: 3306,
      userName: "PizzaApp",
       password: "mynapo2024",
       databaseName: "pizzanapo");

await conn.connect();
}

 
  

