import 'dart:async';
import 'package:flutter/material.dart';
import 'db.dart'; // Importa la función de consulta desde db.dart
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'alertas.dart';
import 'datalogger.dart';
//import 'alerts.dart'; // Importa el archivo random.dart
import 'rango.dart';


void main() {
   //mainAlerts(); 
   runApp(Menu());

} 

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext pantalla) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'MENU',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: refrescaPantalla(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              var resultado = snapshot.data!.first;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Id Sensor: ${resultado['id_sensor']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 200,
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: 0,
                            endValue: 200,
                            color: Colors.black,
                            startWidth: 10,
                            endWidth: 10,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: double.parse(resultado['valor'].toString()),
                            enableAnimation: true,
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Container(
                              child: Text(
                                '°C',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
        bottomNavigationBar: BottomAppBar( color: Colors.black, child: Container( child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[ IconButton( icon: Icon(Icons.notifications, color: Colors.white), onPressed: () {Navigator.push(pantalla, MaterialPageRoute(builder: (context) => Alertas())); }, ), IconButton( icon: Icon(Icons.assignment, color: Colors.white), onPressed: () {Navigator.push(pantalla, MaterialPageRoute(builder: (context) => Datalogger()));}, ), IconButton( icon: Icon(Icons.settings, color: Colors.white), onPressed: () {Navigator.push(pantalla, MaterialPageRoute(builder: (context) => Rango()));}, ), ], ), ), ),
      ),
    );
  }
}

Stream<List<Map<String, dynamic>>> refrescaPantalla() async* {
  while (true) {
    await Future.delayed(Duration(seconds: 5));
    await ejecutarConsulta(
        'SELECT * FROM logger ORDER BY fecha DESC LIMIT 1');
    yield resultadosGlobales;
  }
}

