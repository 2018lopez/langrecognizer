
class Derivation {
	
	Str [] treeData := [""]// Global array to keep track of each derivation
	
	// function accept string and store it on array list
	Void leftMostDer(Str input){
		
		echo("program   →  " + input)// print the derivation 
		treeData.add(input)// add each derivation to treeData array
		
	}
	
	Void printTree(){// Function of printTree - print parse tree
		
		if( treeData[3] == "to vbar <x><y>,<y> end"){//parse and print vbar derivation
                echo("\n-------------------------------------\n")
                echo("\t    Printing Tree")
                echo("\n-------------------------------------\n")
                echo("\t\t    < chart >")
                echo("\t\t/\t|\t\\ ")
                echo("\tto\t  < plot_cmd >\t   end ")

                for(Int i := 0; i < treeData.size; i++){
            
                    if( treeData[i] == "to <cmd> end" ){
                        echo("\t\t / ")
                        echo("\t     < cmd >")
                        echo("\t    /  |  |  \\")
                        i++
                    }
                    if( treeData[i] == "to vbar <x><y>,<y> end" ){
                        echo("\tvbar <x><y>,<y>")
                        i++
                    }
                    
                    if( treeData[i] == treeData[4]){
                        echo("\t      |  |   \\ ")
                        echo("\t     <${treeData[4].getRange(8..8)}><y>,<y>")
                
                        
                    }

                    if(treeData[i] == treeData[4]){
                        echo("\t         |  \\ ")
                        echo("\t        <${treeData[4].getRange(9..9)}>,<y>")
                        echo("\t\t     |")
                        echo("\t\t   ,<${treeData[4].getRange(11..11)}>")
                
                    }        
                }

                echo("\n\t  " + treeData[4])//prints 
			
            }else if(treeData[3] == "to fill <x><y> end"){//parse and prints fill derivation
				
				echo("\n-------------------------------------\n")
                echo("\t    Parse Tree")
                echo("\n-------------------------------------\n")
                echo("\t\t    < chart >")
                echo("\t\t/\t|\t\\ ")
                echo("\tto\t  < plot_cmd >\t   end ")
                
				Int i := 0
                while(i < treeData.size){
					
					
					

                    if( treeData[i] == "to <cmd> end" ){
                        echo("\t\t / ")
                        echo("\t     < cmd >")
                        echo("\t    /  |  |  \\")
                        i++
                    }
					
					
                    if( treeData[i] == "to fill <x><y> end" ){
                        echo("\tfill <x><y>")
                         
                    }
					 
					
					i++
                }
				
            }
            else{// parse and prints hbar derivation
				
                echo("\n-------------------------------------\n")
                echo("\t    Parse Tree")
                echo("\n-------------------------------------\n")
                echo("\t\t    < chart >")
                echo("\t\t/\t|\t\\ ")
                echo("\tto\t  < plot_cmd >\t   end ")

                for(Int i := 0; i < treeData.size; i++){

                    if( treeData[i] == "to <cmd> end" ){
                        echo("\t\t / ")
                        echo("\t     < cmd >")
                        echo("\t    /  |  |  \\")
                        i++
                    }
                    if( treeData[i] == "to hbar <x><y>,<x> end" ){
                        echo("\thbar <x><y>,<y>")
                        i++
                    }

                    if( treeData[i] == treeData[4]){
                        echo("\t      |  |   \\ ")
                        echo("\t     <${treeData[4].getRange(8..8)}><y>,<y>")
                    
                    }

                    if( treeData[i] == treeData[4]){
                        echo("\t        |   \\ ")
                        echo("\t       <${treeData[4].getRange(9..9)}>,<y>")
                        
                    }
                    if( treeData[i] == treeData[4]){
                        echo("\t        |   \\ ")
                        echo("\t            <${treeData[4].getRange(11..11)}>")
                        
                    }
                }
				
				 echo("\n\t  " + treeData[4])//prints 
            }//End else
	}
	
	

}
