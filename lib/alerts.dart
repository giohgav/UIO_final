/* import 'dart:async';
import 'db.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void mainAlerts() {
  Timer.periodic(Duration(seconds: 20), (Timer t) async {
    await ejecutarConsulta(
        'SELECT * FROM logger WHERE (valor > max OR valor < min) ORDER BY fecha DESC LIMIT 1');

    if (resultadosGlobales.isNotEmpty) {
      // Obtiene los valores de la última fila de resultadosGlobales
      Map<String, dynamic> ultimaFila = resultadosGlobales.first;

      // Crea una notificación local con los valores obtenidos
      await _mostrarNotificacionLocal(
          ultimaFila['id_sensor'],
          ultimaFila['fecha'],
          ultimaFila['max'],
          ultimaFila['min'],
          ultimaFila['valor']);
    }
  });
}

Future<void> _mostrarNotificacionLocal(String idSensor, String fecha, double max, double min, double valor) async {
  // Configura el plugin de notificaciones locales
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Configura la inicialización de las notificaciones locales
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Construye el mensaje de la notificación
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Alerta de Sensor',
    'ID Sensor: $idSensor\nFecha: $fecha\nMáximo: $max\nMínimo: $min\nValor: $valor',
    platformChannelSpecifics,
  );
}
 */
/* 
// Codigo funcional
import 'dart:async';
import 'db.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Inicialización del plugin fuera de la función
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void mainAlerts() {
  // Inicialización del plugin
  initializeNotifications();

  // Inicia el temporizador para las alertas
  Timer.periodic(Duration(seconds: 20), (Timer t) {
    try {
      // Lógica asíncrona dentro de un bloque try-catch
      ejecutarConsulta(
          'SELECT * FROM logger WHERE (valor > max OR valor < min) ORDER BY fecha DESC LIMIT 1').then((_) {
        if (resultadosGlobales.isNotEmpty) {
          Map<String, dynamic> ultimaFila = resultadosGlobales.first;
          _mostrarNotificacionLocal(
              ultimaFila['id_sensor'],
/*               ultimaFila['fecha'],
              ultimaFila['max'],
              ultimaFila['min'], */
              ultimaFila['valor']);
        }
      });
    } catch (e) {
      print('Error en la lógica del temporizador: $e');
    }
  });
}

Future<void> initializeNotifications() async {
  // Configura la inicialización de las notificaciones locales
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher_round');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> _mostrarNotificacionLocal(String idSensor, /* String fecha, double max, double min */ double valor) async {
  // Construye el mensaje de la notificación
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    icon: '@mipmap/ic_launcher_round',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Alerta de Sensor',
    'ID Sensor: $idSensor\nValor: $valor',
    platformChannelSpecifics,
  );
}
 */

import 'dart:async';
import 'db.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Inicialización del plugin fuera de la función
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Variable para almacenar los resultados anteriores
Map<String, dynamic> resultadosAnteriores = {};

void mainAlerts() {
  // Inicialización del plugin
  initializeNotifications();

  // Inicia el temporizador para las alertas
  Timer.periodic(Duration(seconds: 20), (Timer t) {
    try {
      // Lógica asíncrona dentro de un bloque try-catch
      ejecutarConsulta(
          'SELECT * FROM logger WHERE (valor > max OR valor < min) ORDER BY fecha DESC LIMIT 1').then((_) {
        if (resultadosGlobales.isNotEmpty) {
          Map<String, dynamic> ultimaFila = resultadosGlobales.first;
          // Verifica si los resultados son diferentes a los anteriores antes de mostrar la notificación
          if (!sonIguales(resultadosAnteriores, ultimaFila)) {
            _mostrarNotificacionLocal(
              ultimaFila['id_sensor'],
              ultimaFila['valor'],
            );
            // Actualiza los resultados anteriores
            resultadosAnteriores = ultimaFila;
          }
        }
      });
    } catch (e) {
      print('Error en la lógica del temporizador: $e');
    }
  });
}

// Función para inicializar las notificaciones
Future<void> initializeNotifications() async {
  // Configura la inicialización de las notificaciones locales
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher_round');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Función para mostrar la notificación local
Future<void> _mostrarNotificacionLocal(String idSensor, double valor) async {
  // Construye el mensaje de la notificación
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    icon: '@mipmap/ic_launcher_round',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Alerta de Sensor',
    'ID Sensor: $idSensor\nValor: $valor',
    platformChannelSpecifics,
  );
}

// Función para comparar dos mapas y verificar si son iguales
bool sonIguales(Map<String, dynamic> mapa1, Map<String, dynamic> mapa2) {
  if (mapa1.length != mapa2.length) return false;
  for (var key in mapa1.keys) {
    if (mapa1[key] != mapa2[key]) return false;
  }
  return true;
}
