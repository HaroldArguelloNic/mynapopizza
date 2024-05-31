import 'package:mysql_client/mysql_client.dart';

class PizzaConnect {
  static String host = '172.17.0.1',
  user = 'PizzaApp',
  db = 'pizzzanapo',
  password = 'mynapo2024';
  static int port = 3306;

  PizzaConnect(); 

Future<MySQLConnection> pizzaConnect() async {

final conn =  MySQLConnection.createConnection(
    host: "172.17.0.1",
     port: 3306,
      userName: "PizzaApp",
       password: "mynapo2024",
       databaseName: "pizzanapo");

return await conn;
}}


