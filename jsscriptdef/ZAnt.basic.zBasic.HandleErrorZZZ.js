	//#############################################
			//### ERROROHANDLING
			//#############################################		
			function handleError(err,objControl){				
				var sReturn="nix";
				var sReturnControl="Fehler im handleError";
				var bReturnControl=false;
				try{
					//Wichtig: Importierere ExceptionZZZ
					importClass(Packages.basic.zBasic.ExceptionZZZ);
				
					var objControlCaller=new Object();
					var sScript=reflectMethodCurrent_Name(null, objControlCaller);
					if(!objControlCaller.bReturnControl) throw new Error("Fehler beim Ermittlen des aktuellen Funktionnamens im ErrorHandling: " + objControlCaller.sReturnControl);
					sScript = sScript + ": ";
					print("################################");
					print("##### in " + sScript + " #######");
				
					//TEST: Versuche aus dem uebergebenen Error-Objekt weitere Infos zu holen
					//PROBLEM: Bei einem geworfenen Java Fehler wird hier kein korrekter Stacktrace und damit auch kein Funktionsname gefunden.
					//                 Versuche also einen eigenen Stacktracktrace zu machen und hole davon dann den "Namen der aufrufenden Funktion".
					var myFunctionCallingName=reflectMethodCalling_Name(null,objControlCaller);
					if(!objControlCaller.bReturnControl) throw new Error("Fehler beim Ermittlen des aufrufenden Funktionnamens im ErrorHandling: " + objControlCaller.sReturnControl);					
					print("gefundener aufrufender Funktionsname: " + myFunctionCallingName);
										
					var myFunctionErrorFoundName="";
					if(err!='undefined' && err!=null){
					    print(sScript+"Error Objekt vorhanden");
						var myFunctionErrorName=reflectMethodCurrent_Name(err, objControlCaller);
						if(!objControlCaller.bReturnControl) throw new Error("Fehler beim Ermittlen des letzten Funktionnamens im ErrorHandling: " + objControlCaller.sReturnControl);					
						print("gefundener error Funktionsname: " + myFunctionErrorName);
						myFunctionErrorFoundName = myFunctionErrorName;
					}else {
						myFunctionErrorFoundName = myFunctionCallingName;
					}
									
				//JAVA 7 (Rhino), hier wird nichts ausgegeben, schade.	Stack ist undefined.
				//JAVA 8 (Nashorn), hier wird die Zeilenummer ausgegeben, nur nicht bei ExceptionZZZ Fehlern.
				//        generell funktioniert es aber unter JAVA 8 (Nashorn): print("TEST, neues ErrorObjekt erzeugen und die Zeilennummer ausgeben: "  + (new Error).lineNumber);			
				
				print("#############################################################");
				print("##### in handle Error fuer den Java oder sonstigen Fehler ###");				
				print("Error Objekt: " + err);//Hier wird in Nashorn der Name der Exception-Klasse direkt zurückgegeben.
				
				//Aber: Wir wollen auf ein ExceptionZZZ Objekt zugreifen. 
				//      Seit Aenderung der Javascript Engine in Nashorn ist dies Unterschiedlich.
				//      In JAVA 8 (Nashorn) steht das Objekt direkter zur Verfügung.
				if(err instanceof ExceptionZZZ) {  //So geht das nur mit NASHORN.					
					print("ExceptionZZZ Fehler abgefangen (NASHORN, Java 8), Zeilennummer steht nicht zur Verfügung");
					print("err.getMessageLast()="+ err.getMessageLast());  //DIE LÖSUNG MIT NASHORN !!!!
					print("err.getFunctionLast()="+ err.getFunctionLast());  //DIE LÖSUNG MIT NASHORN !!!!
							
					sReturn = myFunctionErrorFoundName + ": ExceptionZZZ: '" + err.getFunctionLast() + " - " + err.getMessageLast() + "'.";
					sReturnControl="Alles o.k."; //Das Errorhandling an sich ist o.k.
					bReturnControl=true;
				}else if(err.javaException instanceof ExceptionZZZ) {  // So geht das nur mit RHINO !!!					
					print("ExceptionZZZ Fehler abgefangen (RHINO, Java 7), Zeilennummer steht nicht zur Verfügung");
					print("err.javaException.getMessageLast()="+ err.javaException.getMessageLast());  //DIE LÖSUNG MIT RHINO !!!!
					print("err.javaException.getFunctionLast()="+ err.javaException.getFunctionLast());  //DIE LÖSUNG MIT NASHORN !!!!
							
					sReturn = myFunctionErrorFoundName + ": ExceptionZZZ: '" + err.javaException.getFunctionLast() + " - " + err.javaException.getMessageLast() + "'.";
					sReturnControl="Alles o.k."; //Das Errorhandling an sich ist o.k.
					bReturnControl=true;
										
				}else{
				   //weitere, unbestimmte Fehler abfangen					   
				   print("Unbestimmten Fehler abfangen.");

					var bIsJava7=isJava7(objControlCaller);
					if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);				
					if(bIsJava7){
						print ("Javascript Engine: 'Rhino'");
						print("err.contructor.name="+err.constructor.name);	//In Rhino wird der Fehler nicht direkt zurückgegeben.			
						if(err.constructor.name=='JavaException'){
							print("Error.name=" + err.name);							
							print("Error.getCause=" + err.getCause); //Ergebnis: undefined
							//print("Error.getCause()=" + err.getCause());
							print("Error.message: " + err.message);//Ergebnis der Ausgabe: basic.zBasic.ExceptionZZZ: null;
							//print("Error.message(): " + err.message());//Ergebnis: Es wird ein Fehler geworfen 'is not a function, it is "string"
							//print("Error: " + err.getMessageLast());//Ergebnis: Es wird ein Fehler geworfen 'cannot find function getMessageLast in object JavaException
							//print("Error: " + err.getMessageLast);//Ergebnis: dito, kein Unterschied zu getMessageLast()
							print("err.javaException.getMessage()="+ err.javaException.getMessage());  //DIE ALLGEMEINE LÖSUNG MIT RHINO !!!!
							print("err.rhinoExcption.getScriptStackTrace()="+err.rhinoException.getScriptStackTrace());
							
							sReturn = myFunctionErrorFoundName + ": JavaException: '" + err.javaException.getMessage() + "'.";
							sReturnControl="Alles o.k.";
							bReturnControl=true;
						}else{
							print("normaler Fehler.");
							sReturn = myFunctionErrorFoundName + ": Error: " + err.message;
							sReturnControl="Alles o.k."; //Das Errorhandling an sich ist o.k.
							bReturnControl=true;
						}			
					}else{
						print ("Javascript Engine: 'Nashorn'");						
						print("Fehlerobjekt Zeilennummer: " + err.lineNumber);
						print("Fehlerobjekt Dateiname: " + err.fileName);
				
						sReturn = myFunctionErrorFoundName + ": " + typeof(err) + ": '" + err.message + "'.";												
						sReturnControl="Alles o.k."; //Das Errorhandling an sich ist o.k.
						bReturnControl=true;						
					}
				}		

					}catch(e){
						print(e);					
						bReturnControl=false;
						sReturnControl=sScript+"Fehler im ErrorHandling. "+ e;
					}	
				//print("zuruegegebener controlstring in JS-Unter-Funktion:" + sReturnControl);
				objControl.sReturnControl=sReturnControl;			
				objControl.bReturnControl=bReturnControl;	
				return sReturn;
		}//End function handleError	