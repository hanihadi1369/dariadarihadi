class OperatorFinder{

  // mci 1 , mtn 2 , rightel 3 , unknown 4 , naghes 5

  static int findOperator(String input){
    if(input.length>11){
      return 4;
    }


    if(
    input.startsWith("091") ||
    input.startsWith("0990") ||
    input.startsWith("0991") ||
    input.startsWith("0992") ||
    input.startsWith("0993") ||
    input.startsWith("0994")
    ){
      return 1;
    }
    if(input.startsWith("092")){
      return 3;
    }
    if(input.startsWith("093")||
        input.startsWith("0901") ||
        input.startsWith("0902") ||
        input.startsWith("0903") ||
        input.startsWith("0904") ||
        input.startsWith("0905") ||
        input.startsWith("0941")
    ){
      return 2;
    }



    if(input.length>3){
      return 4;
    }else{
      return 5;
    }

  }

}