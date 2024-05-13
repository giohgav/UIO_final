import 'dart:async';
import 'package:flutter/material.dart';
import 'db.dart'; // Importa la función de consulta desde db.dart
import 'package:date_format/date_format.dart';
import 'menu.dart';

void main() {
  runApp(MaterialApp(
    home: Alertas(),
  ));
}

class Alertas extends StatelessWidget {
  @override
  Widget build(BuildContext pantalla) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Alertas',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              Navigator.of(pantalla).pushReplacement(
                MaterialPageRoute(builder: (context) => Menu()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: refrescaPantalla(), // Utiliza el stream de la consulta
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                // Verifica si hay datos y no son nulos
                return DataTable(
                  columns: [
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Id Sensor')),
                    DataColumn(label: Text('Valor')),
                  ],
                  rows: snapshot.data!.map((resultado) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(_formatDate(
                            resultado['fecha']))), // Formatea la fecha
                        DataCell(Text(resultado['id_sensor'])),
                        DataCell(Text(resultado['valor'].toString())),
                      ],
                    );
                  }).toList(),
                );
              }
              return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
            child: Center(
              child: Text(
                'UIO',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    var date = DateTime.parse(dateString);
    return formatDate(date, [
      dd,
      '/',
      mm,
      '/',
      yy,
      ' ',
      HH,
      ':',
      nn
    ]); // Formatea la fecha usando date_format
  }
}

Stream<List<Map<String, dynamic>>> refrescaPantalla() async* {
  while (true) {
    await Future.delayed(Duration(seconds: 5)); // Actualiza cada 5 segundos

    await ejecutarConsulta(
        'SELECT * FROM logger WHERE valor > max OR valor < min'); // Realiza la consulta a la BD
    //SELECT * FROM logger WHERE valor > max OR valor < min ORDER BY fecha DESC LIMIT 1;
    yield resultadosGlobales; // Devuelve los resultados como un stream
  }
}