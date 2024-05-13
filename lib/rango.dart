/* import 'package:flutter/material.dart';
import 'db.dart'; // Importa el archivo db.dart

void main() {
  runApp(MaterialApp(
    home: Rango(),
  ));
}

class Rango extends StatefulWidget {
  @override
  _RangoState createState() => _RangoState();
}

class _RangoState extends State<Rango> {
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obtenerMinMax(); // Llama a la función para obtener min y max al iniciar
  }

  Future<void> _obtenerMinMax() async {
    await ejecutarConsulta('SELECT min, max FROM sensor'); // Ejecuta la consulta
    if (resultadosGlobales.isNotEmpty) {
      setState(() {
        minController.text = resultadosGlobales[0]['min'].toString();
        maxController.text = resultadosGlobales[0]['max'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext pantalla) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Rango',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.of(pantalla).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: minController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Min',
              ),
            ),
            TextField(
              controller: maxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Max',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                double min = double.parse(minController.text);
                double max = double.parse(maxController.text);
                if (min >= max) {
                  // Valida que min < max
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Error'),
                      content: Text('El valor mínimo debe ser menor que el valor máximo.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                } else {
                  await ejecutarConsulta('UPDATE sensor SET min = "$min", max = "$max"');
                  // Verifica si la actualización fue exitosa
                  if (resultadosGlobales.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Éxito'),
                        content: Text('Valores actualizados correctamente.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: Text('Actualizar'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          child: Center(
            child: Text(
              'UIO',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'db.dart'; // Importa el archivo db.dart

void main() {
  runApp(MaterialApp(
    home: Rango(),
  ));
}

class Rango extends StatefulWidget {
  @override
  _RangoState createState() => _RangoState();
}

class _RangoState extends State<Rango> {
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obtenerMinMax(); // Llama a la función para obtener min y max al iniciar
  }

  Future<void> _obtenerMinMax() async {
    await ejecutarConsulta('SELECT min, max FROM sensor'); // Ejecuta la consulta
    if (resultadosGlobales.isNotEmpty) {
      setState(() {
        minController.text = resultadosGlobales[0]['min'].toString();
        maxController.text = resultadosGlobales[0]['max'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext pantalla) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Rango',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.of(pantalla).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: minController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Min',
              ),
            ),
            TextField(
              controller: maxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Max',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                double min = double.parse(minController.text);
                double max = double.parse(maxController.text);
                if (min >= max) {
                  // Valida que min < max
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Error'),
                      content: Text('El valor mínimo debe ser menor que el valor máximo.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                } else {
                  await ejecutarConsulta('UPDATE sensor SET min = "$min", max = "$max"');
                  // Verifica si la actualización fue exitosa
                  if (resultadosGlobales.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Éxito'),
                        content: Text('Valores actualizados correctamente.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: Text('Actualizar'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          child: Center(
            child: Text(
              'UIO',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
