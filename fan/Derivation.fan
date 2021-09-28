
class Derivation {
	
	Str [] treeData := [""]
	
	// function accept string and then print content of the string	
	Void leftMostDer(Str input){
		
		echo("program   →  " + input)
		treeData.add(input)
	
		
		
	}
	
	Void printTree(){
		
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
                
            }
			
            if( treeData[i] == "to vbar <x><y>,<y> end" ){
                echo("\tvbar <x><y>,<y>")
               
            }
             
//            echo(treeData[i] + "<<<<<<<<<")
//            echo(">>>>" + treeData[4].getRange(8..8))
            if( treeData[i] == treeData[4]){
                echo("\t      |  |   \\ ")
                echo("\t     <${treeData[4].getRange(8..8)}><y>,<y>")
                
                
            }
            
			echo(i.toStr + " :::::::::::" + treeData[i])
            echo("::::::::" + treeData[4] )
            if(treeData[i] == treeData[5]){
//                echo("\t         |  \\ ")
//                echo("\t        <${treeData[5].getRange(9..9)}>,<y>")
//                echo("\t\t     |")
//                echo("\t\t   ,<${treeData[5].getRange(11..11)}>")
               
            }   
				
				 i++

        }

//        echo("\n\t  " + treeData[4])
//		
	}
	
	

}
