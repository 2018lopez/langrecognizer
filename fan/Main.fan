using afPegger::Peg

class Main {
	
	Void main(){
	
		//declare grammer variable 
		 grammer :=
			"<chart> = to <plot_cmd> end 			
			 <plot_cmd> = <cmd>  | <cmd> ; < plot_cmd >
			 <cmd> = vbar <x><y>,<y> | hbar <x><y>,<x> | fill <x><y>
			
			 <x> =  1 | 2 | 3 | 4 | 5 | 6 | 7
			 <y> = 1 | 2 | 3 | 4 | 5 | 6 | 7 "
			 		
		
			// Display Grammer and Commands
			echo("-------------------------------------")
			echo("Allowed Grammer:")
			echo("\n")
			echo(grammer)
			echo("-------------------------------------")
			echo("Commands: STOP to end the program and  g to display allowed Grammer")
			echo("-------------------------------------")
			echo("\n")

		langRec := LangRecognizer()// declare object for lang Recognizer class
		Bool program_status := true // declare a variable for program state
		
		while( program_status){
			
			echo("\n")
			input := Env.cur.prompt("Enter a String Input: ")// ask user for input
			echo("\n")
			
			
			try{
				
				if( input.upper == "STOP"){ // verify if the input is equal to stop and if yes program exist
					echo("\n")
					echo("-------------------------------------")
					echo("Program Ended")
					echo("-------------------------------------")
					break
				}
				
				if ( input.lower == "g"){ // verify if the input is equal to g and if yes display allowed grammer
					
					echo("\n")
					echo("Allowed Grammer:")
					echo("\n")
					echo(grammer)
					echo("-------------------------------------")
					
					
				}
				
				
				if(input.lower != "g"){ // verify if the input is equal g to avoid that g is validate 
					
					langRec.getInput(input)
				}
			
				
				
			}catch(CastErr e){
				
				echo(e)
			}
			
			

			
			
		}
		 

	}

}
