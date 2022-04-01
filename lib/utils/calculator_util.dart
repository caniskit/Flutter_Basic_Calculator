class CalculatorUtil{
static const List<String> operators = ['+','-','X','/','%'];
static const List<String> commands = ['AC','DEL','+/-','.','='];
  bool isOperator(String operator){
    return operators.contains(operator);    
  }

  bool isCommand(String command){
    return commands.contains(command);
  }
  

bool isNumber (String s){
 if(double.tryParse(s)!=null){
   return true;
 }
 return false;
} 

bool isNegativeNumber(String s){
  if(isNumber(s)&& s.contains('-')){
    return true;
  }
  return false;
}
int hasPresedence(String op ){
  switch(op){
    case'+':
    case'-':
     return 1;
    case'%':
    case'X':
    case'/':
      return 2;

  }return 0;
  
}
String doCalculate(List<String> equation){
  
  isOperator(equation.last) ? equation.removeLast():null;
  
  while(equation.length>1){
  print('hesp');
  for(int i=1;i<equation.length-1;i+=2){
    var op= equation[i];
    double fnum = double.parse(equation[i-1]);
    double snum = double.parse(equation[i+1]);
    if(hasPresedence(op)==2)
      {
         switch(op){
          case'X':
            equation[i-1]=(fnum*snum).toString();
            equation.removeAt(i);
            equation.removeAt(i);
            break;
          case '/':
             equation[i-1]=(fnum/snum).toString();
             equation.removeAt(i);
             equation.removeAt(i);
             break;
          case '%':
             equation[i-1]=(fnum%snum).toString();
             equation.removeAt(i);
             equation.removeAt(i);
             break;
        }
      }
    } 
  for(int i=1;i<equation.length-1;i+=2){
    var op= equation[i];
    double fnum = double.parse(equation[i-1]);
    double snum = double.parse(equation[i+1]);
    switch(op){
        case '+':
            equation[i-1]=(fnum+snum).toString();
            equation.removeAt(i);
            equation.removeAt(i);
            break;
        case '-':
            equation[i-1]=(fnum-snum).toString();
            equation.removeAt(i);
            equation.removeAt(i);
            break;


    }
    }

  }


  return equation.first;
}

}