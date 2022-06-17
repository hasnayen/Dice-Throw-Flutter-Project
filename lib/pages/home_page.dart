import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _diceList = <String>[
    'picture/d1.jpg',
    'picture/d2.jpg',
    'picture/d3.jpg',
    'picture/d4.jpg',
    'picture/d5.jpg',
    'picture/d6.jpg',
  ];
  int _index1 = 0, _index2 = 0, _diceSum = 0, _point = 0, winf = 0, lostf=0;
  String msg ='';
  bool _hasGameStarted = false;
  bool _hasGameFinished = false;
  final _random = Random.secure();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: const Text('Dice Roll')),
      ),
      body: Center(
       child:!_hasGameStarted? _startPage():_gamePage(),
        //child: _gamePage(),
      ),
    );
  }
  Widget _startPage(){

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
           Color(0xFF701ebd),Color(0xFF873bcc),Color(0xFFfe4a97),Color(0xFFe17763),Color(0xFF68998c),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: Column(
        children: [

          Image.asset('picture/pic.png',width: 200, fit: BoxFit.cover , alignment: Alignment.topCenter),
          SizedBox(height: 50,),
          Container(
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: ElevatedButton.icon(

              label: const Text('START',),
              icon: Icon(Icons.arrow_right),

              onPressed: (){
        setState((){
            _hasGameStarted = true;

        });
      }, style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 50),

            ),

            ),
          ),
          SizedBox(height: 50,),
          Center(child: Text("!!!RULES!!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(''''** You can roll two dice. Each die has six faces. These faces contain 1,2,3,4,5, and 6 spots. ** After the dice have come to rest, the sum of the spots on the two upward faces is calculated. If the sum is 7 or 11 on the first throw, the player wins. ** If the sum is 2,3, or 12 on the first throw, you lose ** If the sum is 4,5,6,8,9, or 10 on the first throw, then that sum becomes the player’s “points.” To win, you must continue rolling the dice until you make your points.''', textAlign: TextAlign.justify,),
            ) ,
          )
        ],
      ),
    );
  }
  Widget _gamePage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_diceList[_index1], width: 100, height: 100,),
            SizedBox(width: 5,),
            Image.asset(_diceList[_index2], width: 100, height: 100,),

          ],
        ),
        ElevatedButton(
          onPressed:_hasGameFinished? null: _rollTheDice,
          child:const Text('ROLL'),
        ),
        Column(
          children: [
            Text('Dice Sum : $_diceSum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            if(_point > 0)Text('$_diceSum',),
            Text('$msg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent))
          ],
        ),
        if(_point>0 && !_hasGameFinished)const Text(
          'Keep rolling untill you get the result', style: (
        TextStyle(
          backgroundColor: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,

        )
        ),
    ),
        if(_hasGameFinished)Text(msg, style: TextStyle(fontSize: 25),),
          ElevatedButton(onPressed: _resetGame
              , child: Text('PLAY AGAIN'), )
      ],
    );
  }

  void _rollTheDice() {
    setState(() {

        _index1 = _random.nextInt(6);
        _index2 = _random.nextInt(6);
        _diceSum = _index1 + _index2 + 2;
        if (_point > 0) {
          _checkSecondThrow();
        } else {
          _checkFirsThrow();
        }
      });






        }
  _resetGame(){
    setState((){
      _hasGameStarted = false;
      _hasGameFinished = false;
      _index2 =0 ;
      _index1 = 0;
      _point = 0;
      _diceSum = 0;
      msg = '';
    });
  }
  void _checkFirsThrow(){
    if (_diceSum == 7 && _diceSum == 11) {
      msg = "Congratulation!!!\n YOU WIN!!! ";
      _hasGameFinished = true;
    }
    else if (_diceSum == 2 && _diceSum == 3 && _diceSum == 12) {
      msg ="Try again, You Lose ";
      _hasGameFinished = true;
    }
    else{
      _point = _diceSum;
    }
  }
  void _checkSecondThrow(){
    if(_diceSum == _point){
      msg = 'Congratulation You Win';
      _hasGameFinished = true;

    }
    else if(_diceSum == 7){
      msg = 'try Again You Lose';
      _hasGameFinished = true;
    }
  }

      }




