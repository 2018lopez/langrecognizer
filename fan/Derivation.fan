
class Derivation {
	
	
	
	Void leftMostDer(Str input){
		
		Str temp :=""
		data := input.split
		to := data[0]
		end := data[data.size-1]
		
		chart :=  " <program>  → " + to +  " <plot_cmd> " + end 
		
		
		plot_cmd := "<program>  → " + to + " <cmd>; <plot_cmd> " + end
		
	
		
		echo(data)
		echo(chart)
		echo(plot_cmd)
		
		
	}
	
	Void printDerivation(){
		
	}
}
