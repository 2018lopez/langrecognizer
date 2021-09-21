

	
class LangRecognizer:Derivation {

	Int chartValidate := 0	
	
	
	 Void getInput(Str input ){
			
		der := Derivation()

			
		data :=input
		parserGrammer(data)
		der.leftMostDer(data)
	}
	

	
	Void leftMost(Str data){
		
		grammer :=
			"<chart> = to <plot_cmd> end 			
			 <plot_cmd> = <cmd>  | <cmd> ; < plot_cmd >
			 <cmd> = vbar <x><y>,<y> | hbar <x><y>,<x> | fill <x><y>
			
			 <x> =  1 | 2 | 3 | 4 | 5 | 6 | 7
			 <y> = 1 | 2 | 3 | 4 | 5 | 6 | 7"
	
	
		
	}
	
	
	
	Void parserGrammer(Str input){
		
		data := input.split
		Bool v := validateString(data)
		
		validateChart(v)
		ValidatePlotCmd(data)
		
			
		
	}
	
	Void validateChart(Bool data){
		
		if(data){
			
			echo("sytnax correct")
			
		}else{
			
			
			if( chartValidate == 1){
				
			
				
				echo("Error: Syntax end of String is an invalid value - should end with 'end'  ")
				
			}else if( chartValidate == 2){
				
				echo("Error: Syntax start and end of String is an invalid value ")
				
			}else{
				
					echo("Error: Syntax start of String is an invalid value - should start with 'to'  ")
				
			}
			
			
		}
	}
	
	Bool validateString(Str [] data){
		
		chartStart := "to"
		chartEnd := "end"
		lastElement := data[data.size - 1]
		
		
		if( data[0] == chartStart && lastElement == chartEnd ){
			
			return true
		}else{
			
			if( lastElement != chartEnd && data[0] != chartStart){
				
				chartValidate = chartValidate + 1
			}
			
			if( lastElement != chartEnd  ){
				chartValidate++
				
			}
			
			
			
			
			return false
		}
	}
	
	Void ValidatePlotCmd(Str [] data){
		
		lastElement := data[data.size - 1]
		firstElement := data[0]
		
		plot_cmd := data.getRange(1 ..data.size - 2)
		
		
		
		echo(plot_cmd)
		
		
	}
	
	
	
}
