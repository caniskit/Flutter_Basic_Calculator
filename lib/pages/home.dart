import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key ?key, required this.text,required this.callback
  }) : super(key: key);
  final String text;
  final Function callback;

    @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1.5),
        child: SizedBox(
          width: 96,
          height: 96,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text('${text}',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            onPressed: () => callback(text),
            color: Colors.purple,
            textColor: Colors.white,
          ),
        )
    );
  }
}

class dCalculatorHome extends StatefulWidget {
  const dCalculatorHome({ Key? key }) : super(key: key);

  @override
  State<dCalculatorHome> createState() => _dCalculatorHomeState();
}

class _dCalculatorHomeState extends State<dCalculatorHome> {
  String top='';
  String bottom='';
  List<String> calculation=[];
  List<String> input=[];
  List<String> history=[];

  bool isInteger(String last){
    if(int.tryParse(last)!=null){
      return true;
    }
    return false;
  }

  bool lastOperator(List check){         
    int i=check.length-1;
    for(;i>=0;i--){
      if(int.tryParse(check[i])==null && check[i]=='.'){
        return false;
      }
      else{
        if(int.tryParse(check[i])==null){
          return true;
        }
      }
    }
    return true;
  }

  void listTransfer(List list1, List list2){
    int j=0;
    list2.clear();
    for(int i=0; i<list1.length;i++){
      if(isInteger(list1[i]) || list1[i]=='.' || list1[i]=='-'){
        list2[j]=list2[j]+list1[i];
      }
      else{
        j++;
        list2[j]=list2[j]+list1[i];
      }
    }
  }

  void npTranslator(List list){
    int i=list.length-1;
    for(;i>=0;i--){
      if(!isInteger(list[i]) && lastOperator(list)){
        if(list[i+1].contains('-')){
          list[i+1]=list[i+1].substring(1,list[i+1].length);
        }
        else
          list[i+1]='-'+list[i+1];
        break;
      }
      else {
        if (!isInteger(list[i])) {
          if (list[i + 1].contains('-')) {
            list[i + 1] = list[i + 1].substring(1, list[i + 1].length);
          }
          else
            list[i + 1] = '-' + list[i + 1];
        }
        else {
          if (i == 0) {
            if (list[i].contains('-')) {
              list[i] = list[i].substring(1, list[i].length);
            }
            else
              list[i] = '-' + list[i];
          }
        }
      }
    }
  }

  void equation(List list){
    int i;
    for(i=0;i<list.length;){
      if(list[i]=='X' || list[i]=='/' || list[i]=='%'){
        switch (list[i]) {
          case 'X':
            list[i-1]=double.parse(list[i-1])*double.parse(list[i+1]);
            list.removeAt(i);
            list.removeAt(i);
            break;
          case '/':
            list[i-1]=double.parse(list[i-1])/double.parse(list[i+1]);
            list.removeAt(i);
            list.removeAt(i);
            break;
          case '%':
            list[i-1]=double.parse(list[i-1])%double.parse(list[i+1]);
            list.removeAt(i);
            list.removeAt(i);
            break;
        }
      }
      else
        i++;
    }
    for(;list.length>1;){
      if(list[1]=='+'){
        list[0]=double.parse(list[0])+double.parse(list[2]);
        list.removeAt(1);
        list.removeAt(1);
      }
      else{
        list[0]=double.parse(list[0])-double.parse(list[2]);
        list.removeAt(1);
        list.removeAt(1);
      }
    }
  }

  void btnOnClick(String btnVal){
    setState( (){
      switch (btnVal) {
        case 'C':
          input.clear();
          history.clear();
          bottom=input.join('');
          top=history.join('');
          break;
        case 'DEL':
          if(input.isNotEmpty){
            input.removeLast();
          }
          bottom=input.join('');
          break;

        case '/':
          if(input.isNotEmpty && isInteger(input.last)){
            input.add(btnVal);
          }
          bottom=input.join('');
          break;
        case 'X':
          if(input.isNotEmpty && isInteger(input.last)){
            input.add(btnVal);
          }
          bottom=input.join('');
          break;
        case '-':
          if(input.isNotEmpty && isInteger(input.last)){
            input.add(btnVal);
          }
          bottom=input.join('');
          break;
        case '+':
          if(input.isNotEmpty && isInteger(input.last)){
            input.add(btnVal);
          }
          bottom=input.join('');
          break;
        case '%':
          if(input.isNotEmpty && isInteger(input.last)){
            input.add(btnVal);
          }
          bottom=input.join('');
          break;
        case '.':
          if(input.isNotEmpty && isInteger(input.last)){
            if(lastOperator(input)){
              input.add(btnVal);
            }
          }
          else {
            if ((input.isNotEmpty && !isInteger(input.last)) || input.isEmpty){
              if(lastOperator(input)){
                input.add('0');
                input.add(btnVal);
              }
            }
          }
          bottom=input.join('');
          break;
        case '+/-':
          npTranslator(input);
          bottom=input.join('');
          break;
        case '=':
          listTransfer(input, calculation);
          history.add(input.join(''));
          equation(calculation);
          input.clear();
          input[0]=calculation[0];
          break;
        default:
          input.add(btnVal);
          bottom=input.join('');
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DAC Calculator')
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text(
                    top,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.purple,
                    ),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    bottom,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(text:'C', callback: btnOnClick,),
                  CustomButton(text:'DEL', callback: btnOnClick,),
                  CustomButton(text:'%', callback: btnOnClick,),
                  CustomButton(text:'/', callback: btnOnClick,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(text:'7', callback: btnOnClick,),
                  CustomButton(text:'8', callback: btnOnClick,),
                  CustomButton(text:'9', callback: btnOnClick,),
                  CustomButton(text:'X', callback: btnOnClick,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(text:'4', callback: btnOnClick,),
                  CustomButton(text:'5', callback: btnOnClick,),
                  CustomButton(text:'6', callback: btnOnClick,),
                  CustomButton(text:'-', callback: btnOnClick,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(text:'1', callback: btnOnClick,),
                  CustomButton(text:'2', callback: btnOnClick,),
                  CustomButton(text:'3', callback: btnOnClick,),
                  CustomButton(text:'+', callback: btnOnClick,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(text:'+/-', callback: btnOnClick,),
                  CustomButton(text:'0', callback: btnOnClick,),
                  CustomButton(text:'.', callback: btnOnClick,),
                  CustomButton(text:'=', callback: btnOnClick,),
                ],
              ),
            ],
          ),
        ),
      );
  }
}