
	
class LangRecognizer:Derivation {
	
	//Declare string to store derivation everytime a validate occurs
	Str inputString :=""
	
	
	// function to get user input and other function to validate grammer and create derivation
	 Void getInput(Str input ){
				
		data :=input
		parserGrammer(data)
	  }
	
	//String is parse and validate by section
	Void parserGrammer(Str input){
	
		treeV := Tree()
		
	// Split String pass by user by space
		data := input.split(' ')
	
	//validate the first element and last element of the string 
		if(validateFirstLast(data)){// if validateString return false it print error and does not continue to process data
			
			// validate the rest of content in the string exclude out the first and last element 	
			ValidatePlotCmd(data)
		}

	}	
		

	//Function validateFirstLast - validate the first and last element in the string
	Bool validateFirstLast(Str [] data){
		
		//declare variables
		chartStart := "to" // allow first element
		chartEnd := "end" // allow last element
		lastElement := data[data.size - 1] // last element on the string
		
	
		if(  data[0] != chartStart){// validate to first element of the string and if its not equal to chartStart a error is printed
				
			errorHandler("Error Syntax:  ${data[0]} is an invalid sytnax.",  "String should begin with:  ${chartStart}")
			return false
		}
			
		if( lastElement != chartEnd  ){// validate the last element of the string and if  its not equal to chartEnd a error is printed
			errorHandler("Error Syntax:  ${lastElement} is an invalid sytnax."," String should end with:  ${chartEnd}")
			return false
		}
		
		return true
	}
	
	//validate data excluding the first and last element of the string
	Void ValidatePlotCmd(Str [] data){
		
		//Allowed X and Y values 
		x := ["1", "2","3","4","5","6","7"]
		y := ["1", "2","3","4","5","6","7"]

		
		der := Derivation()// declare derivation object
		plot_cmd := data.getRange(1 ..data.size - 2)// get content from string excluding the first and last element in the string
		inputSize := plot_cmd.size// string size
		
		inputString ="to <plot_cmd> end"// initial derivation 
		der.leftMostDer(inputString)// add derivation 
		
		index := 0//declare index to loop through string and keep track of current position in the string  

		while( index < inputSize){
			
			Bool position := true// declare to bool variable to keep track of the ; character 
			
			for(Int i := 0; i < plot_cmd[index+1].size  ; i++){//loop through string to verify if a ; exist 
				
				
				if(plot_cmd[index+1].getRange(i..i) == ";"){// if any character in the string equal to ; . The position is set to false
					
					position = false
		
				}
			
			}
			
			//verify position value accordingly then process to create the derivation 
			if(position){
				
				inputString = inputString.replace("<plot_cmd>","<cmd>")
		
			}else{
				
				inputString = inputString.replace("<plot_cmd>", "<cmd> ; <plot_cmd>")
			
			}
			
			//add derivation
			der.leftMostDer(inputString)
	
			//validate if string element is equal to vbar, hbar , fill. if not a error is throw
			if(plot_cmd[index] == "vbar" || plot_cmd[index] == "hbar"){
				
				//split string at , and semicolon 
				temp := plot_cmd[1].split(',')
				tempy := temp[1].toStr.split(';')
				
				//get value of x and y from string the parse above
				coordx := temp[0].toStr
				coordy := tempy[0]
				
				
				if(plot_cmd[index] == "vbar"){// if element is equal to vbar then data is process accordingly vbar allowed syntax
									
					inputString = inputString.replace("<cmd>", "vbar <x><y>,<y>")//derivation is created for vbar
					der.leftMostDer(inputString)//add latest derivation
					
					if(!validateCoord(coordx, index)){//validate xy value 
						
						return false
					}
					
					//derivation error replace both y 
//					tempI := coordx.getRange(1..1)
//					inputString = inputString.replace(",${tempI}",",<y>")
//					der.leftMostDer(inputString)
					
					if(coordy.size != 1){// validate the second y and verify it a single digit number 
						
						errorHandler("Error : ${coordy} - ${coordy.size} size isn't correct", "Y valid numbers: ${y}")
					}
				
					if(!validateY(coordy.getRange(0..0))){//validate the second y in vbar element
					
						errorHandler("Error Sytnax: ${coordy} is a invalid y", "Y valid numbers: ${y}")
						return false
					}
					
					//derivation created for second y
					inputString = inputString.replace("<y>", "${coordy.getRange(0..0)}")
					der.leftMostDer(inputString)//add derivation
				
					
				}else{ // validating for hbar element
					
					//split string at , and semicolon 
						xtemp := plot_cmd[index+1].toStr.split(',')
						xtempx := xtemp[1].toStr.split(';')
					
					//new values for xy after parsing 
						xValue := xtemp[0]
						xSvalue :=  xtempx[0]
					
					inputString = inputString.replace("<cmd>", "hbar <x><y>,<x>")//derivation created for hbar
					der.leftMostDer(inputString)// add derivation
					
					if(!validateCoord(xValue, index)){//validate xy values
						
						return false
					}
					
					
					if(!validateX(xSvalue)){// validate second x in the hbar element
						
						return false
					}
					
					inputString = inputString.replace("<x>", "${xSvalue}")//derivation created for second x
					der.leftMostDer(inputString)//add derivation
					
				}
				
				//increment index 
				index = index +=2
				
			}else if( plot_cmd[index]== "fill"){// validate fill element
				
				if(index+1 > plot_cmd.size){//verify size of the fill element
					
					errorHandler("Statement does not meet the minimum arguments","Verify string enter with grammer")
				}
			
				if(plot_cmd[index+1] == ";" || plot_cmd[index+1] == "end"){// verify that data on fill element

					errorHandler("Statement does meet the minumum arguments","String enter at ${plot_cmd[index+1]}")
				}
				
					tempCoord := plot_cmd[index+1]//get xy values from element

				if(plot_cmd[index] == "fill"){
					
					inputString = inputString.replace("<cmd>", "fill <x><y>")//derivation created for fill
					der.leftMostDer(inputString)//add derivation
					
					if(!validateCoord(tempCoord, index)){// validate the values for xy in the fill element
						
						return false
					}
				}
				
				//increment index
				index+=3
				
			}else{
				
				errorHandler("Error Synatx: ${plot_cmd[index]} an invalid statement", "Valid Statement: vbar, hbar, fill")
				index +=5
			}

		}
		
		return true
		
	}
	
	//Function ValidateCoord - validate xy values pass in
	Bool validateCoord(Str  dataInput, Int position){
		
		//Allowed X and Y values
		x := ["1", "2","3","4","5","6","7"]
		y := ["1", "2","3","4","5","6","7"]
		
		
		//parse data remove space or comma - store x values to datax and store y value to datay
		data := dataInput.getRange(0..1)
		datax := dataInput.getRange(0..0)
		datay := dataInput.getRange(1..1)
		
		//create object for derivation class and to access the 
		der := Derivation()
		
		//verify that value pass is a double digit number
		if( data.size != 2){
			
			errorHandler("Error Sytnax: ${data} is invalid sytnax","Correct sytnax should look : 22")
			return false
		}
		
		//validate value for x
		if(!validateX(datax)){
			
			errorHandler("Error Sytnax: ${datax} is an invalid for x ", "Valid x values are: ${x}")
			return false
		}
		
		//derivation for x value
		inputString = inputString.replace("<x>", datax)
		
		//hbar special derivation because it replace both x 
		temps := datax.getRange(0..0)
		inputString = inputString.replace(",${temps}",",<x>")
					
		der.leftMostDer(inputString)
	
		//validate value for y
		if(!validateY(datay)){
			
			errorHandler("Error Sytnax: ${datay} is an invalid for y **", "Valid y values are: ${y}")
			return false
		}
		
		//derivation for y value
		inputString = inputString.replace("<y>", datay)
		
		//derivation second y - fix bug that replace both y values with the same value
		tempI := datay.getRange(0..0)
		inputString = inputString.replace(",${tempI}",",<y>")
		
		der.leftMostDer(inputString)//add derivation for y values
		
		return true
	}
	
	//Function validateX - validate x value pass and verify that its equal to x allow numbers
	Bool validateX(Str data){
		
		//array of allow x values
		x := ["1", "2","3","4","5","6","7"]
		
		//loop through x array and verify if a value is equal to the value pass in
	    for(Int i := 0; i < x.size; i++){
	      if( data == x[i]){
	      
	        return true
	      }
	    }

	    return false

	}
	
	// Function validateY - validate y value pass and verify that its equal to y allow numbers
	Bool validateY(Str data){
		
		//array of allow y values
		y := ["1", "2","3","4","5","6","7"]
		
		//loop through y array and verify if a value is equal to the value pass in
	    for(Int i := 0; i < y.size; i++){
	      if( data == y[i]){
			
	        return true
	      }
	    }
    
	    return false
	}
	
	//Function errorHandler - prints error, accepts two string arguments
	Void errorHandler(Str msg, Str error ){
		
		echo(msg + error) // print the error pass
	}

}
