

class Tree {
	
	Str [] treeData := [""]
	
	Void dataTree(Str [] data){
		
	treeData = data
		
	echo(treeData)
		
//	
//	echo("\n Parse Tree")
//		
//	
//	echo("\t\t    <program>")
//
//    echo("\t\t/\t|\t\\ ")
//
//    echo("\tbegin\t   <stmt_list>\t   end ")          
//  
//    echo("\t\t\t| ")
//  
//    echo("\t\t      <stmt>")
//  
//    echo("\t\t/\t|\t\\ ")
//
//    echo("\t   <var>\t=\t   <expr> ")
//
//    echo("\t  /\t\\ ")

	}
	
	Void printTree(){
		
		echo("\n-------------------------------------\n")
        echo("\t    Printing Tree")
        echo("\n-------------------------------------\n")
        echo("\t\t    < chart >")
        echo("\t\t/\t|\t\\ ")
        echo("\tto\t  < plot_cmd >\t   end ")
		
       echo("Size::::::::::::" + treeData.size)
       echo(treeData.toStr + "<<<<<<<<<<<<<<<<<<<")

          for(Int i := 0; i < treeData.size; i++){
            
			echo(":::::::::::::::::::::")
            if( treeData[i] == "to <cmd> end" ){
                echo("\t\t / ")
                echo("\t     < cmd >")
                echo("\t    /  |  |  \\")
                i++
            }
			echo(treeData[i])
            if( treeData[i] == "to vbar <x><y>,<y> end" ){
                echo("\tvbar <x><y>,<y>")
                i++
            }
            
//            if( treeData[i] == treeData[4]){
//                echo("\t      |  |   \\ ")
//                echo("\t     <${treeData[4].getRange(0..0)}><y>,<y>")
//                i++
//                
//            }
//
//            if(treeData[i] == treeData[5]){
//                echo("\t         |  \\ ")
//                echo("\t        <${treeData[5].getRange(9..9)}>,<y>")
//                echo("\t\t     |")
//                echo("\t\t   ,<${treeData[5].getRange(11..11)}>")
//                i++
//            }        

        }

//        echo("\n\t  " + treeData[5])
	}
		
   
    
}
