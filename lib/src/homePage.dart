import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int clicks = 0;
  bool sw = false;
  bool sw1 = true;
  String jugador ='X';
  List<List<String>> tablero = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Turno del jugador $jugador', style: TextStyle(fontSize: 35),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            contenedor(0, 0),
            contenedor(0, 1),
            contenedor(0, 2)
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            contenedor(1, 0),
            contenedor(1, 1),
            contenedor(1, 2)
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            contenedor(2, 0),
            contenedor(2, 1),
            contenedor(2, 2)
          ]
        ),
        ElevatedButton(onPressed: (){
          sw ? null: reiniciar();
        }, child: Text('Reiniciar')
        )
      ],
      
    );
  }

  Widget contenedor(int i, int j){
    return GestureDetector(
      onTap: () {
        click(i, j);
        print('object');
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        height: 100,
        width: 100,
        alignment: Alignment.center,
        color: Colors.amber,
        child: Text(
          tablero[i][j], 
          style: const TextStyle(fontSize: 60),
        ),
      )
    );
  }

  Future alerta(BuildContext context, String j){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Jugador $j gano'),
        content: const Text('Reiniciar?'),
        actions: [
          TextButton(onPressed: (){
            SystemNavigator.pop();
          }, child: Text('NO')),
          TextButton(onPressed: (){
            reiniciar();
            Navigator.pop(context);
          }, child: Text('SI'))
          
        ],
      );
    });
  }
  Future alertaEmpate(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('EMPATE :c'),
        content: const Text('Reiniciar?'),
        actions: [
          TextButton(onPressed: (){
            SystemNavigator.pop();
          }, child: Text('NO')),
          TextButton(onPressed: (){
            reiniciar();
            Navigator.pop(context);
          }, child: Text('SI'))
          
        ],
      );
    });
  }

  void click(int x, int y){
    setState(() {
      tablero [x][y] = jugador;
      jugador == 'X' ? jugador = '0': jugador = 'X';
    });
    gano(x, y);
    clicks++;
    if(clicks > 9){
      alertaEmpate(context);
      print('empate');
      clicks = 0;
      print('$clicks : clicks');
    }
  }

  void gano(int x, int y){
    var horizontal = 0;
    var vertical = 0;
    var diagonal = 0;
    var diagonalSec = 0;
    var jugadorAux = tablero[x][y];
    for(var i = 0; i < 3; i++){
      if(tablero[x][i] == jugadorAux) horizontal++;
      if(tablero[i][y] == jugadorAux) vertical++;
      if(tablero[i][i] == jugadorAux) diagonal++;
      if(tablero[i][2-i] == jugadorAux) diagonalSec++;
    } 
    if(horizontal == 3 || vertical == 3 || diagonal == 3 || diagonalSec == 3){
      alerta(context, jugadorAux);
    } 
  }

  void reiniciar(){
    clicks = 0;
    print('$clicks : clicks');
    setState(() {
      tablero = [
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ];
    jugador = 'X';
    });
  }
}