//#############################################
//### Hilfsfunktion JAVA
//#############################################	
function readJavaVersionString(){
	var sScript="readJavaVersionString: ";
	var sReturn="";
	var bReturnControl=false;
	var sReturnControl=sScript+"Fehler";
	try {			
		var version = java.lang.System.getProperty("java.version");
		//print(sScript + "Java Version:" + version);
						
		sReturn=version;
		bReturnControl=true;
		sReturnControl=sScript + "Alles o.k.";
	}catch(err){
		//#### SIMPLES ERROR HANDLING #######
		//print(err);					
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;								
	return sReturn;
}//End function readJavaVersionString

function isJava7(objControl){	
	var sScript="isJava7: ";
	var bReturn = false;
	var bReturnControl=false;
	var sReturnControl=sScript+"Fehler";
	try {			
		var version = readJavaVersionString();
		//print("Java Version:" + version);
		
		var sVersion = version.toString();
		//print(sScript + "typeof sVersion: " + typeof sVersion);
		if(sVersion.substring(0,3)=="1.7"){
			bJava7found=true;
		}else {
			bJava7found=false;
		}
		
		bReturn=bJava7found;
		bReturnControl=true;
		sReturnControl=sScript + "Alles o.k.";
	}catch(err){
		//#### SIMPLES ERROR HANDLING #######
		//print(err);					
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;								
	return bReturn;
}//End function isJava7

function isJava8(objControl){	
	var sScript="isJava8: ";
	var bReturn = false;
	var bReturnControl=false;
	var sReturnControl=sScript+"Fehler";
	try {			
		var version = readJavaVersionString();
		//print("Java Version:" + version);
		
		var sVersion = version.toString();
		//print(sScript + "typeof sVersion: " + typeof sVersion);
		if(sVersion.substring(0,3)=="1.8"){
			bJava8found=true;
		}else {
			bJava8found=false;
		}
		
		bReturn=bJava8found;
		bReturnControl=true;
		sReturnControl=sScript + "Alles o.k.";
	}catch(err){
		//#### SIMPLES ERROR HANDLING #######
		//print(err);					
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;								
	return bReturn;
}//End function isJava8
	
//Todo: Diese Funktion in den JSZ Kernel packen
function enableJava(){
	/* Diese Funktion stellt alles bereit, um von JavaScript aus auf Java zuzugreifen.
	   - Stelle Kompatibilität zu Java 7 (Rhino) her, um importPackage, importClass nutzen zu können, die es im neuen Java 8 (Nashorn) nicht gibt.
	   - ....
	*/
	
	//zu Testzwecken:
	var version = readJavaVersionString();
	//print("Java Version:" + version);
	
	//var test = java.lang.System.getProperty("java.class.path");
	//println("classpath="+test);
	
	//Merke: Damit wird auch unter Java 8 (Nashorn) die alte Java 7 (Rhino) Funktionalität bereitgestellt.
	try{
		load("nashorn:mozilla_compat.js"); //Das wirft ausser in Java 8 einen Fehler.
		//print("Verwende das alte Rhino unter Java 8");
	}catch(e){
		//print("Verwende Standard JavaScript Engine dieser Java Vesion.");
	}
}//End function enableJava
		