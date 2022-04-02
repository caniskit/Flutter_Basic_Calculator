import 'package:basic_calc_app/utils/calculator_util.dart';
import 'package:flutter/material.dart';



class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key, required this.title}) : super(key: key);

  
  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  CalculatorUtil calc = CalculatorUtil();
  String input='';
  String result='';
  String number='';
  List<String> elements =[];
  final List<String> calcItems = ['AC','DEL','%','/','7','8','9','X','4','5','6','-','1','2','3','+','+/-','0','.','='];
  
  void handleCalculator(String item ){
   setState(() {
    if(calc.isOperator(item)|| calc.isCommand(item))
    {switch (item) {
      case 'AC': 
      
      input ='';
      result='';
      number='';
      elements.clear();
      break;

      case 'DEL':
      if(elements.isNotEmpty){
        calc.isNumber(elements.last)? calc.isNegativeNumber(elements.last) && elements.last.length==2? elements.removeLast(): elements.last.length>1 ? elements.last=elements.last.substring(0,elements.last.length-1):elements.removeLast():elements.removeLast(); 
       input=elements.join('');}
      
      break;
      case '+/-':
      if(elements.isNotEmpty && calc.isNumber(elements.last)){
      elements.last.contains('-')?elements.last=elements.last.substring(1,elements.last.length):elements.last='-'+elements.last;
      input=elements.join('');}
      break;

      case '.':
      if(elements.isEmpty||calc.isOperator(elements.last)){
        elements.add('0.');
      }else if(
        calc.isNumber(elements.last)&&!elements.last.contains('.'))
        {elements.last=elements.last+'.';}
      
      break;
      case '+':
      if(elements.isNotEmpty && !calc.isOperator(elements.last) ){
      elements.add("+");
      input += '+';}
      break;
      
      case '-':
      if(elements.isNotEmpty && !calc.isOperator(elements.last) ){
      elements.add("-");
      input += '-';}
      break;
      
      case '/':
      if(elements.isNotEmpty && !calc.isOperator(elements.last) ){
      elements.add("/");
      input += '/';}
      break;
      
      case 'X':
      if(elements.isNotEmpty && !calc.isOperator(elements.last) ){
      elements.add("X");
      input += 'X';}
      break;
      
      case '%':
      if(elements.isNotEmpty && !calc.isOperator(elements.last)){
      elements.add("%");
      input += '%';}
      break;

      case '=':
      if(elements.isNotEmpty){
      result=calc.doCalculate(elements);
      input=result; }
      break;
    }
      return;
    }
    if(calc.isNumber(item))
    {
      if(elements.isNotEmpty && !calc.isOperator(elements.last)) {
        elements.last+=item;
      }else {
        elements.add(item);
      }
      input=elements.join('');
      return;

    }
   });
  }

  @override
  Widget build(BuildContext context) {
       
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body:  SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container( 
              padding: const EdgeInsets.only(right: 20,left: 20,top: 10),  
              height:40,
              alignment: Alignment.centerRight,
              child: Text('$input',style: const TextStyle(fontSize: 20),),),
              Container( 
              padding: const EdgeInsets.only(right: 20,left: 20,top: 10),  
              height:106,
              alignment: Alignment.centerRight,
              child: Text('$result',style: const TextStyle(fontSize: 56),),),
              const Divider(),
              SizedBox(
                height: 500,
                child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,), 
                itemCount: calcItems.length,
                itemBuilder: (BuildContext ctx, int index){
                  return ElevatedButton( onPressed: () => {
                    
                    handleCalculator(calcItems[index]),
                  },
                    child: Text(calcItems[index],style: index==0 ? TextStyle(color: Colors.red ,fontSize: 26):TextStyle(color: Colors.white,fontSize: 26),),
                    style: index==0 ? ElevatedButton.styleFrom(primary: Colors.white54,):
                    index==calcItems.length-1? ElevatedButton.styleFrom(primary: Colors.red):
                    ElevatedButton.styleFrom()
                    );
                  
                }),
              ),

            ]),
        
      ),      
      
    );
  }
}
