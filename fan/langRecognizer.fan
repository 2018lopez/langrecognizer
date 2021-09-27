
	
class LangRecognizer:Derivation {

	Str inputString :=""
	
	// function to get user input and other function to validate grammer and create derivation
	 Void getInput(Str input ){
				
		data :=input
		parserGrammer(data)
		
	}
	
	//String is parse and validate by section
	Void parserGrammer(Str input){
		
		der :=Derivation()
		data := input.split(' ')
	

		validateString(data)// to end
		ValidatePlotCmd(data)

		

	}	
		
		

	
	// Start and end of String is validate
	Void validateString(Str [] data){
		
		//declare variables
		chartStart := "to"
		chartEnd := "end"
		lastElement := data[data.size - 1]
		
	
			
			if(  data[0] != chartStart){// validate to first element of the string
				
				errorHandler("Error Syntax:  ${data[0]} is an invalid sytnax.",  "String should begin with:  ${chartStart}")
				return
			}
			
			if( lastElement != chartEnd  ){// validate the last element of the string
				errorHandler("Error Syntax:  ${lastElement} is an invalid sytnax."," String should end with:  ${chartEnd}")
			}
	
	}
	
	//validate data excluding the first and last element of the string
	Void ValidatePlotCmd(Str [] data){
		
		lastElement := data[data.size - 1]// remove the first and last element in the string
		firstElement := data[0]// first element
		
		x := ["1", "2","3","4","5","6","7"]
		y := ["1", "2","3","4","5","6","7"]


		der := Derivation()
		plot_cmd := data.getRange(1 ..data.size - 2)
		//Str [] test  := plot_cmd
		
		inputSize := plot_cmd.size
		
		inputString ="to <plot_cmd> end"
		der.leftMostDer(inputString)
		
		index := 0
		
	
		while( index < inputSize){
			
			Bool position := true
			
			for(Int i := 0; i < plot_cmd[index+1].size  ; i++){
				
				
				if(plot_cmd[index+1].getRange(i..i) == ";"){
					
					position = false
					
				}
			
			}

			if(position){
				
				inputString = inputString.replace("<plot_cmd>","<cmd>")
				
				
			}else{
				
				inputString = inputString.replace("<plot_cmd>", "<cmd> ; <plot_cmd>")
				
					
			}
			der.leftMostDer(inputString)
			
			
			
			//validate if string element is equal to vbar, hbar , fill. if not a error is throw
			
			if(plot_cmd[index] == "vbar" || plot_cmd[index] == "hbar"){
				
				
//				if(index+4 > inputSize){
//					
//					errorHandler("Error Syntax: ", "Input String does not contain minimun arguments")
//				}
//				
			
				temp := plot_cmd[1].split(',')
				tempy := temp[1].toStr.split(';')
				
				coordx := temp[0].toStr
				coordy := tempy[0]
				
				
				
				
				
				
				if(plot_cmd[index] == "vbar"){
									
					inputString = inputString.replace("<cmd>", "vbar <x><y>,<y>")
					
					der.leftMostDer(inputString)
					
					if(!validateCoord(coordx, index)){
						
						return false
					}
					
				
					if(coordy.size != 1){
						
						errorHandler("Error : ${coordy} - ${coordy.size} size isn't correct", "Y valid numbers: ${y}")
					}
					
					
					
					echo(coordy.getRange(0..0))
					if(!validateY(coordy.getRange(0..0))){
						
						
						errorHandler("Error Sytnax: ${coordy} is a invalid y", "Y valid numbers: ${y}")
						return false
						
					}
					
					echo(coordy)
					echo(coordx.getRange(1..1) + "  " + coordy.getRange(0..0))
					echo(inputString)
					inputString = inputString.replace("<y>", "${coordy.getRange(0..0)}")
					echo(inputString)
					der.leftMostDer(inputString)
				
					
				}else{ // validating for hbar
					
					
					echo("Hbar************************")
					inputString = inputString.replace("<cmd>", "hbar <x><y>,<x>")
					der.leftMostDer(inputString)
					
					if(!validateCoord(coordx, index)){
						
						return false
					}
					
					
					if(!validateX(coordy)){
						
						return false
					}
					
					inputString = inputString.replace("<x>", "${coordy}")
					der.leftMostDer(inputString)
					
				}
				
				index = index +=2
				
				
				
			}else if( plot_cmd[index]== "fill"){
				
				if(index+1 > plot_cmd.size){
					
					errorHandler("Statement does not meet the minimum arguments","Verify string enter with grammer")
				}
//				
				if(plot_cmd[index+1] == ";" || plot_cmd[index+1] == "end"){

					
					errorHandler("Statement does meet the minumum arguments","String enter at ${plot_cmd[index+1]}")
				}

				
				tempCoord := plot_cmd[index+1]
				 
				
				
				if(plot_cmd[index] == "fill"){
					
					
					inputString = inputString.replace("<cmd>", "fill <x><y>")
					der.leftMostDer(inputString)
					
					if(!validateCoord(tempCoord, index)){
						
						return false
					}
					
					
				}
				
				
				index+=3
				
			}else{
				
				errorHandler("Error Synatx: ${plot_cmd[index]} an invalid statement", "Valid Statement: vbar, hbar, fill")
				index +=5
			}
			
		
		}
		
		
		return true
		
	}
	
	Bool validateCoord(Str  dataInput, Int position){
		
		//Allowed X and Y values
		x := ["1", "2","3","4","5","6","7"]
		y := ["1", "2","3","4","5","6","7"]
		
		
		// 
		data := dataInput.getRange(0..1)
		datax := dataInput.getRange(0..0)
		datay := dataInput.getRange(1..1)
		
		//create object for derivation class
		der := Derivation()
		
		
		//validate values for xy
		
		if( data.size != 2){
			
			errorHandler("Error Sytnax: ${data} is invalid sytnax","Correct sytnax should look : 22")
			return false
		}
		
		//validate values for x
		if(!validateX(datax)){
			
			errorHandler("Error Sytnax: ${datax} is an invalid for x ", "Valid x values are: ${x}")
			return false
		}
		
		
		inputString = inputString.replace("<x>", datax)
		
		der.leftMostDer(inputString)
		
		
		//validate values for y
		
		if(!validateY(datay)){
			
			errorHandler("Error Sytnax: ${datay} is an invalid for y **", "Valid y values are: ${y}")
			return false
		}
		
		inputString = inputString.replace("<y>", datay)
		der.leftMostDer(inputString)
		
		return true
	}
	
	Bool validateX(Str data){
		
		
		x := ["1", "2","3","4","5","6","7"]

	    for(Int i := 0; i < x.size; i++){
	      if( data == x[i]){
	      
	        return true
	      }
	    }
    
	    return false

		
	}
	
	
	Bool validateY(Str data){
		
		der := Derivation()
	
	y := ["1", "2","3","4","5","6","7"]

	    for(Int i := 0; i < y.size; i++){
	      if( data == y[i]){
				
	       
	        return true
	      }
	    }
    
	    return false
	}
	
	//Error Hanlder function - Print Errors
	Void errorHandler(Str msg, Str error ){
		
		echo(msg + error)
	}
	
	
	
}
