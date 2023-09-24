import 'package:flutter/material.dart';
//this mathematical expression package has been imprted here because it is now in our pubspec.yaml file
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget{
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList =[
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      //below is the code for the part where the resultt and the userInput are going to be placed
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/4,
            child: Column(mainAxisAlignment:MainAxisAlignment.end,
            children:[
              Container(
                padding: EdgeInsets.all(5),
              alignment:Alignment.centerRight,
              child:Text(
                userInput,
                style: TextStyle(
                  fontSize:  28,
                  color:  Colors.white,
                ),
              ),
              ),
              Container(
                padding: EdgeInsets.all(10),
              alignment:Alignment.centerRight,
              child:Text(
                result,
                style: TextStyle(
                  fontSize:  34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),
              
            ],),
          ),
          //below is the code for the buttons on the calculator and their colors,fontsizes,the divider color and others
          Divider(color: Colors.white),
          Expanded(
            child: Container(
            padding:EdgeInsets.all(5),
            child: GridView.builder(
              itemCount: buttonList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing:4,
              ),
              itemBuilder: (BuildContext context, int index){
                return CustomButton(buttonList[index]);
              } ),
          ),)
        ],
      ),
    );
  }
//this is a customized button we made for our calculator buttons
  Widget CustomButton(String text){
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: (){
        setState(() {
          buttonFunctionality(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 0.4,
              offset: Offset(-3,-3),
            ),
          ],

        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color:getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ) ,)
      ),
    );
  }
//below are the various colors of the operational buttons
  getColor(String text){
    if(text =="/"||
    text ==")"||
    text =="("||
    text =="+"||
    text =="C"||
    text =="*"||
    text =="-"){
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String text){
    if(text =="AC") {
      return Color.fromARGB(255,252,100,100);
    }
    if(text =="="){
      return Color.fromARGB(255, 104, 204, 159);
    }
    return Color(0xFF1d2630);
  }

  //this is the code for the functionality of the buttons;this where we actually make them usuable
  buttonFunctionality(String text){
    if(text== "AC"){
      userInput ="";
      result ="0";
      return;
    }
    if(text=="C"){
      if(userInput.isNotEmpty){
        userInput= userInput.substring(0, userInput.length -1);
        return;
      }
      else{
        return null;
      }
    }

    if(text == "="){
      result= calculate();
      userInput = result;

      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        return;
      }
    }

    userInput=userInput+text;
  }
//this is  the stage where we import the flutter matheematical expression package into the pubspec.yaml(see pubspec.yaml to see the location of the package)
  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "Error";
    }
  }
} 