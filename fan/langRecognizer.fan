
	
class LangRecognizer:Derivation {

	Int chartValidate := 0	
	
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
		firstElement := data[0]
		
		x := ["1", "2","3","4","5","6","7"]
		y := ["1", "2","3","4","5","6","7"]


		der := Derivation()
		plot_cmd := data.getRange(1 ..data.size - 2)
		//Str [] test  := plot_cmd
		
		inputSize := plot_cmd.size
		
		inputString :="to <plot_cmd> end"
		der.leftMostDer(inputString)
		
		index := 0
		
	
		while( index < inputSize){
			
			Bool position := true
			
			for(Int i := 0; i < plot_cmd[1].size  ; i++){
				
				
				if(plot_cmd[1].getRange(i..i) == ";"){
					
					position = false
					
				}
			
			}

			if(position){
				
				inputString = "<cmd>"
				der.leftMostDer(inputString)
				
			}else{
				
				inputString = inputString.replace("<plot_cmd>", "<cmd> ; <plot_cmd>")
				der.leftMostDer(inputString)
					
			}
			
			//r.leftMostDer(inputString)
			
			
			//validate if string element is equal to vbar, hbar , fill. if not a error is throw
			
			if(plot_cmd[index] == "vbar" || plot_cmd[index] == "hbar"){
				
				
				if(index+4 > inputSize){
					
					errorHandler("Error Syntax", "Input String does not contain minimun arguments")
				}
				
			
				temp := plot_cmd[1].split(',')
				tempy := temp[1].toStr.split(';')
				
				coordx := temp[0].toStr
				coordy := tempy[0]
				
				
				
				
				
				
				if(plot_cmd[index] == "vbar"){
									
					inputString = inputString.replace("&lt;cmd&gt;", "vbar &lt;x&gt;&lt;y&gt;,&lt;y&gt;")
					//insert to der object
					
					if(!validateCoord(coordx, index)){
						
						return false
					}
					
				
					if(coordy.size != 1){
						
						errorHandler("Error : ${coordy} - ${coordy.size} size isn't correct", "Y valid numbers: ${y}")
					}
					
					
					
					
					if(!validateY(coordy)){
						
						
						errorHandler("Error Sytnax: ${coordy} is a invalid y", "Y valid numbers: ${y}")
						return false
						
					}
					
					
					inputString = inputString.replace("&lt;y&gt;", "${coordy}")
					//ll der to store derivation
				
					
				}else{ // validating for hbar
					
					echo("hbar here")
					
					inputString = inputString.replace("&lt;cmd&gt;", "hbar &lt;x&gt;&lt;y&gt;,&lt;y&gt;")
					//call der to store derivation
					
					if(!validateCoord(coordx, index)){
						
						return false
					}
					
					
					if(!validateCoord(coordy, index)){
						
						return false
					}
					
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
//				if(plot_cmd[index+2] == ";" || plot_cmd[index+2] == "end"){
//
//					
//					errorHandler("Statement does meet the minumum arguments","String enter at ${plot_cmd[index+2]}")
//				}
				
				tempCoord := plot_cmd[index+1]
				 
				
				
				if(plot_cmd[index] == "fill"){
					
					
					inputString = inputString.replace("&lt;cmd&gt;", "fill &lt;x&gt;&lt;y&gt;,&lt;y&gt;")
					//call der function to save
					
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
		
		x := ["1", "2","3","4","5","6","7"]
		y := ["1", "2","3","4","5","6","7"]
		
		
		
		data := dataInput.getRange(0..1)
		datax := dataInput.getRange(0..0)
		datay := dataInput.getRange(1..1)
		
		
		
		
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
		
		
		//validate values for y
		
		if(!validateY(datay)){
			
			errorHandler("Error Sytnax: ${datay} is an invalid for y **", "Valid y values are: ${y}")
			return false
		}
		
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
