//###############################################################
		//### REFLECTION 
		//###############################################################
		function reflectMethodCurrent_Name(myError, objControl){
			var sScript="reflectMethodCurrent_Name: ";				
			var sReturn="";
			var bReturnControl=false;
			var sReturnControl="Fehler";
			try{	                    
				var objControlCaller = new Object();
				var sLine=reflectMethodCurrent_StackLine(myError, objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				//print(sScript +"sLine="+sLine);
											
				var sMethod=reflectMethod_StackMethodFromLine(sLine, objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);												
				
				sReturn=sMethod;
				bReturnControl=true;
				sReturnControl=sScript+"Alles o.k.";								
			}catch(err){
				//#### SIMPLES ERROR HANDLING #######
				print(err);					
				bReturnControl=false;
				sReturnControl=sScript+"Fehler. "+ err;					
			}
			//print(sScript+"sReturn="+sReturn);
			objControl.bReturnControl=bReturnControl;
			objControl.sReturnControl=sReturnControl;
			return sReturn;
		}//End function reflectMethodCurrentName		
			
		//#################################################################
		function reflectMethodCurrent_StackLine(myError, objControl){
			var sScript="reflectMethodCurrent_StackLine: ";
			var sReturn="";
			var bReturnControl=false;
			var sReturnControl=sScript+"Fehler";				
			try{
				var objControlCaller = new Object();
				//Java7 funktioniert -	var sCallerLine=reflectMethod_StackLine(myError, 3, objControlCaller);
				//Java8 Fall, ohne übergebenen Error Objekt. Dann muss nämlich der Stack erst errechnet werden: funktioniert mit zwei weiteren Indexpositionen mehr!
				//                                                                 var sCallerLine=reflectMethod_StackLine(myError, 5, objControlCaller);					
				var iIndex = getStackLineIndexCurrent(objControlCaller);					
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				
				var sCallerLine=reflectMethod_StackLine(myError, iIndex, objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				
				//print(sScript+"CallerLine="+sCallerLine);
				sReturn=sCallerLine;
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
		}//End function reflectMethodCurrent_StackLine
		
		function getStackLineIndexCurrent(objControl){
			var sScript="getStackLineIndexCurrent: ";
			var iReturn=-1;
			var bReturnControl=false;
			var sReturnControl=sScript+"Fehler";				
			try{
				var objControlCaller = new Object();
			   var bIsJava7 = isJava7(objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				
				//Die Indexposition ist verschieden, sowohl wg. eines anders aussehenden Stacktraces als auch wg. mehr aufgerufener Funktionen, diesen auszuwerten.
				if(bIsJava7){
					iIndex=3;
				}else{
					iIndex=5;
				}
				//print(sScript+"iIndex="+iIndex);
				iReturn=iIndex;
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
			return iReturn;		
		}
		
		
		//#################################################################
		function reflectMethodCalling_Name(myError, objControl){
			var sScript="reflectMethodCalling_Name: ";				
			var sReturn="";
			var bReturnControl=false;
			var sReturnControl="Fehler";
			var objControlCaller = new Object();
			try{	
				var sMethod="";							
				
				var sLine=reflectMethodCalling_StackLine(myError, objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				//print(sScript +"sMethodCallingLine="+sLine);
											
				sMethod=reflectMethod_StackMethodFromLine(sLine, objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);												
				
				sReturn=sMethod;
				bReturnControl=true;
				sReturnControl=sScript+"Alles o.k.";								
			}catch(err){
				//#### SIMPLES ERROR HANDLING #######
				print(err);					
				bReturnControl=false;
				sReturnControl=sScript+"Fehler. "+ err;					
			}
			//print(sScript+"sReturn="+sReturn);			
			objControl.bReturnControl=bReturnControl;
			objControl.sReturnControl=sReturnControl;
			return sReturn;
		}//End function reflectMethodCurrentName		
		
		//#################################################################
		function reflectMethodCalling_StackLine(myError, objControl){
			var sScript="reflectMethodCalling_StackLine: ";
			//print(sScript+"START");
			var sReturn="";
			var bReturnControl=false;
			var sReturnControl=sScript+"Fehler";
			try{
				var objControlCaller = new Object();
				//Java7: funktioniert? var sCallerLine=reflectMethod_StackLine(myError,4, objControlCaller); //iIndex um einen mehr als bei ...MethodCurrent...
				//Java8 Fall funktioniert, ohne übergebenen Error Objekt. Dann muss nämlich der Stack erst errechnet werden: funktioniert mit zwei weiteren mehr? 
				//                                                                                   var sCallerLine=reflectMethod_StackLine(myError,6,objControlCaller); //iIndex um einen mehr als bei ...MethodCurrent...
				
				var iIndex = getStackLineIndexCurrent(objControlCaller);					
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				
				var iIndexCalling = iIndex + 1;
				
				var sCallerLine=reflectMethod_StackLine(myError,iIndexCalling, objControlCaller); //iIndex um einen mehr als bei ...MethodCurrent...
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
									
				//print(sScript+"CallerLine="+sCallerLine);
				sReturn=sCallerLine;
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
		}//End function reflectMethodCurrent_StackLine
		
					
//#####################################################################
//### REFLECTION-COMMON Funktionen, sowohl für current als auch für calling Methodennamen
//#####################################################################
		function reflectMethod_StackLine(myError, iIndex, objControl){
			var sScript="reflectMethod_StackLine: ";
			var sReturn="";
			var bReturnControl=false;
			var sReturnControl=sScript+"Fehler";
							
			try{
				var sCallerLine="";
				
				if(iIndex=='undefined' || iIndex==null){
					iIndex=3;//-1 wg. Index an sich, -1 weil es eine Unterfunktion entweder von ....current oder ...calling ist, -2 wg. der Tatsache, dass man DIESE Funktion nicht haben will, sondern die aufrufende.
				}					
			
				var objControlCaller = new Object();
				var bIsJava7=isJava7(objControlCaller);
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				
				//Merke Java 7: Nur wenn man tatsächlich einen Fehler provoziert, bekommt man einen Stacktrace.
				//ACHTUNG: Wir Suchen als Funktion das VORLETZTE Element in dem Array
				if(bIsJava7){		
					//print(sScript+"7: Ausfuehrung unter Java7");					
					if('undefined'!=myError && null!=myError){					
						if(undefined!=myError.stack){		
							print(sScript+"7: Stack im Error Objekt vorhanden");
							var saStacktrace = myError.stack.split("\n");						
							//print(sScript + "7: Vorhandener StackTrace=" + saStacktrace);
							var iuBound=saStacktrace.length-1;
							//print(sScript + "7: iuBound="+iuBound);
							if(iIndex>iuBound){
								iIndex=iuBound-2; //-1, weil der letzte Wert nicht interessiert, sondern der vorletzte, -1 weil wir in der UnterUnterfunkton sind.
							}
							sCallerLine = saStacktrace[(iIndex)];
						} else {
							//Normal in Java7, da kein Stacktrace im error-objekt vorhanden ist.
							print(sScript+"7: KEIN Stack im Error Objekt vorhanden");
							var saStacktrace=createStackTrace();
							//print(sScript + "7: Erstellter StackTrace=" + saStacktrace);
							var iuBound=saStacktrace.length-1;
							//print(sScript + "7: iuBound="+iuBound);
							if(iIndex>iuBound){
								iIndex=iuBound-2; //-1, weil der letzte Wert nicht interessiert, sondern der vorletzte, -1 weil wir in der UnterUnterfunkton sind.
							}
							sCallerLine = saStacktrace[(iIndex)];
						}				
					}else{
						//print(sScript+"7: KEIN Error Objekt vorhanden");
						var saStacktrace=createStackTrace();
						//print(sScript + "7: Erstellter StackTrace=" + saStacktrace);
						var iuBound=saStacktrace.length-1;
						//print(sScript + "7: iuBound="+iuBound);
						if(iIndex>iuBound){
							iIndex=iuBound-2; //-1, weil der letzte Wert nicht interessiert, sondern der vorletzte, -1 weil wir in der UnterUnterfunkton sind.
						}
						sCallerLine = saStacktrace[(iIndex)];
					}					
				}else{
					//print(sScript+"8: Ausfuehrung unter Java8");
					if('undefined'!=myError && null!=myError){					
						if(undefined!=myError.stack){		
							//Java 8, NASHORN funktioniert.
							//print(sScript + "8: Error Stack vorhanden");
							//print(sScript + "8: Error Stack=" + myError.stack);
							var saStacktrace = myError.stack.split("\n");
							//print(sScript + "8: Gefundener StackTrace=" + saStacktrace);
							var iuBound=saStacktrace.length-1;
							//print(sScript + "8: iuBound="+iuBound+"; iIndex="+iIndex);
							if(iIndex>iuBound){
								iIndex=iuBound-2; //-1, weil der letzte Wert nicht interessiert, sondern der vorletzte, -1 weil wir in der UnterUnterfunkton sind.
							}			
							var iIndexToBeUsed=1;
							//print(sScript + "8: iuBound="+iuBound+"; iIndex to be used="+iIndexToBeUsed);								
							sCallerLine = saStacktrace[(iIndexToBeUsed)];
						} else {
							//Ungewöhnlich in Java 8 - wenn kein error-objekt vorhanden ist, vermutlich wurde kein Error Objekt übergeben.
							//print(sScript + "8: KEIN Error Stack vorhanden OBWOHL Error Objekt vorhanden ist.");														
							var stack=createStackTrace();
							var saStacktrace = stack.split("\n");
							//print(sScript + "8: Erstellter StackTrace=" + saStacktrace);	
							var iuBound=saStacktrace.length-1;									
							//print(sScript + "8: iuBound="+iuBound+"; iIndex="+iIndex);
							if(iIndex>iuBound){
								iIndex=iuBound-2; //-1, weil der letzte Wert nicht interessiert, sondern der vorletzte, -1 weil wir in der UnterUnterfunkton sind.
							}									
							var iIndexToBeUsed=iIndex+1;
							//print(sScript + "8: iuBound="+iuBound+"; iIndex to be used="+iIndexToBeUsed);								
							sCallerLine = saStacktrace[(iIndexToBeUsed)];
						}				
					}else{
						//Vermutlich Java7, da kein Stacktrace im error-objekt vorhanden ist.
						//print(sScript + "8 ohne ErrorObjekt");
						
						var stack=createStackTrace();
						var saStacktrace = stack.split("\n");
						//print(sScript + "8 ohne ErrorObjekt=" + saStacktrace);	
						var iuBound=saStacktrace.length-1;
						//print(sScript + "8: iuBound="+iuBound+"; iIndex="+iIndex);
						if(iIndex>iuBound){
							iIndex=iuBound-2; //-1, weil der letzte Wert nicht interessiert, sondern der vorletzte, -1 weil wir in der UnterUnterfunkton sind.
						}								
						var iIndexToBeUsed=iIndex;
						//print(sScript + "8: iuBound="+iuBound+"; iIndex to be used="+iIndexToBeUsed);								
						sCallerLine = saStacktrace[(iIndexToBeUsed)];
					}
				}
				//print(sScript+"CallerLine="+sCallerLine);
				sReturn=sCallerLine;
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
		}//End function reflectMethod_StackLine

//#################################################################
function reflectMethod_StackMethodFromLine(sStackLine, objControl){
	var sScript="reflectMethod_StackMethodFromLine: ";
	var sReturn = sStackLine;					
	var bReturnControl=false;
	var sReturnControl=sScript+"Fehler";
	try {
		if(undefined==sStackLine || null==sStackLine) throw new Error(sScript+"Parameter Stacktrace-Zeile fehlt.");
											
		var objControlCaller=new Object();
		var bJava7=isJava7(objControlCaller);					
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
		
		var clean2="";
		if(bJava7){
			//print(sScript+"Java 7 Zweig. sStackLine="+sStackLine);
			var index = sStackLine.indexOf(" (");
			var clean = sStackLine.slice(index+2, sStackLine.length);
			
			var index2 = clean.indexOf(")");							
			if(index2>=1){
				clean2 = clean.substring(0,index2).trim();
			}else{
				clean2 = clean.trim();
			}			
		} else {
			//Java8
			//print(sScript+"NICHT Java 7 Zweig. sStackLine="+sStackLine);
			var index = sStackLine.indexOf("at ");
			//print(sScript+"index="+index);
			var clean = sStackLine.slice(index+2, sStackLine.length);						
			//print(sScript+"clean="+clean);
			
			
			index = clean.indexOf(" (");
			var clean = clean.substring(0,index);
			//print(sScript+"clean="+clean);
			
			clean2 = clean.trim();
		}
		sReturn=clean2;					
		bReturnControl=true;
		sReturnControl=sScript + "Alles o.k.";
	}catch(err){
		//#### SIMPLES ERROR HANDLING #######
		print(err);					
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}	
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;								
	//print(sScript+"sReturn="+sReturn);
	return sReturn;
}//End function reflectMethod_StackMethodFromLine
		
//#########################################
//### Hilfsfunktion zur Generierung eines Stacktraces. Als Workaround für Java7. 
//#########################################			
function createStackTrace() {
  var sScript="createStackTrace: ";
  var callstack = [];
  var isCallstackPopulated = false;
  try{
	var objControlCaller=new Object();
	var bJava7=isJava7(objControlCaller);					
	if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
	
if(bJava7){		
  // print(sScript+"Java7 Fall");
  //+++ Java7 Fall
  try {
	i.dont.exist+=0; //doesn't exist- that's the point
  } catch(e) {
	if (e.stack) { //Firefox
		//print("ffox");
		//print(e.stack);
	  var lines = e.stack.split('\n');
	  for (var i=0, len=lines.length; i<=len-1; i++) {
		//print(i + ": '" + lines[i].trim() +"'");
		//klappt hier nicht....  if (lines[i].trim().match(/^\s*[A-Za-z0-9\-_\$]+\(/)) {
		if (lines[i].trim()!=''){
		  //print("line used");
		  callstack.push(lines[i]);
		}else		 {
		  //print("empty line NOT used");  				
		}
	  }
	  
	  //Remove call to printStackTrace()
	  callstack.shift();
	  isCallstackPopulated = true;
	}
	else if (window.opera && e.message) { //Opera
		print("opera  untested");
	  var lines = e.message.split('\n');
	  for (var i=0, len=lines.length; i<len; i++) {
		if (lines[i].match(/^\s*[A-Za-z0-9\-_\$]+\(/)) {
		  var entry = lines[i];
		  //Append next line also since it has the file info
		  if (lines[i+1]) {
			entry += ' at ' + lines[i+1];
			i++;
		  }
		  callstack.push(entry);
		}
	  }
	  //Remove call to printStackTrace()
	  callstack.shift();
	  isCallstackPopulated = true;
	}
  }
  if (!isCallstackPopulated) { //IE and Safari
	print("ie untested");
	var currentFunction = arguments.callee.caller;
	while (currentFunction) {
	  var fn = currentFunction.toString();
	  var fname = fn.substring(fn.indexOf("function") + 8, fn.indexOf('')) || 'anonymous';
	  callstack.push(fname);
	  currentFunction = currentFunction.caller;
	}
  }
  //+++ ENDE Java7 Fall
  //+++ START Java8 Fall
  }else{
	print(sScript+"Java8 Fall");
	try {
		var objError = new Error();
		callstack=objError.stack;
	} catch(e) {
	
	}
  
  
  }
  }catch(err){
		//#### SIMPLES ERROR HANDLING #######
		print(err);					
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}
	//+++ ENDE Java8 Fall
  
  //output(sScript, callstack);
  return callstack;
}

function output(sScript, arr) {
  //Optput however you want
  //alert(arr.join('\n\n'));
  print(sScript +"arr="+ arr);
  //print(arr.join('\n\n'));
}	

//#############################################
    //### Hilfsfunktion JAVA
	//#############################################	
		function isJava7(objControl){	
			var sScript="isJava7: ";
			var bReturn = false;
			var bReturnControl=false;
			var sReturnControl=sScript+"Fehler";
			try {			
				var version = java.lang.System.getProperty("java.version");
				//print("Java Version:" + version);
				
				if(version.substring(0,3)=="1.7"){
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
			
			//Todo: Diese Funktion in den JSZ Kernel packen
			function enableJava(){
			/* Diese Funktion stellt alles bereit, um von JavaScript aus auf Java zuzugreifen.
			   - Stelle Kompatibilität zu Java 7 (Rhino) her, um importPackage, importClass nutzen zu können, die es im neuen Java 8 (Nashorn) nicht gibt.
			   - ....
			*/
			
				//zu Testzwecken:
				var version = java.lang.System.getProperty("java.version");
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
			
								
				//##################################################################
				//### Tryouts den Stacktrace vom Error objekt zu bekommen
				//##################################################################
				
				//produziert in Java7 KEINEN Stacktrace
				function stackTrace() {
				  try {
					var err = new Error("test02");
					throw err;
				  } catch (err) {
					print("eeee " + err);
					//print(err.rhinoException.printStackTrace());
					print(err.stack);
					return err.stack;
				  }
				}
				
				//produziert in Java7 KEINEN Stacktrace
				function errorTraced() {
				  try {
					var err = new Error("test01");
					throw err;
				  } catch (err) {
					print("ddddd " + err);
					//print(err.rhinoException.printStackTrace());
					print(err.stack);
					return err;
				  }
				}
				
				