//###################################################################
//#### KERNEL LIBS INCLUDED
//###################################################################
function usedKernelAntLibJs(objKernelLibs, sDirSubDefault, objControl){			
	var sScript = "usedKernelAntLibJs: ";
	if(objKernelLibs==undefined || objKernelLibs==null){
		var err = new Error("objKernelLibs nicht deklariert.");
		throw err;
	}
	if(sDirSubDefault==undefined || sDirSubDefault==null){				
		sDirSubDefault="jsscriptdef";
	}else if(sDirSubDefault.trim()==''){
		sDirSubDefault="jsscriptdef";
	}
	//print("sDirSubDefault="+sDirSubDefault);
	
	//Erstelle eine Array der grundlegenden JavaScript-Kernel Funktionen, die in externen Dateien ausgelagert wurden.				
	var bReturn=false; 
	var bReturnControl=false;
	var sReturnControl="Fehler";						
	try{					
		objKernelLibs[0] = new Object();
		objKernelLibs[0]["ALIAS"] = "HandleKernel";
		objKernelLibs[0]["DIRECTORY"] = sDirSubDefault;
		objKernelLibs[0]["FILE"] = "ZAnt.basic.zBasic.HandleKernelZZZ.js";  //Wird auch in enableKernelAntJs direkt eingelesen und mit eval ausgeführt, damit diese grundlegende Funktion überhaupt zur Verfügung steht.
		
		objKernelLibs[1] = new Object();
		objKernelLibs[1]["ALIAS"] = "ReflectCode";
		objKernelLibs[1]["DIRECTORY"] = sDirSubDefault;
		objKernelLibs[1]["FILE"] = "ZAnt.basic.zBasic.ReflectCodeZZZ.js";

		objKernelLibs[2] = new Object();
		objKernelLibs[2]["ALIAS"] = "HandleError";
		objKernelLibs[2]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[2]["FILE"] = "ZAnt.basic.zBasic.HandleErrorZZZ.js";
												
		objKernelLibs[3] = new Object();
		objKernelLibs[3]["ALIAS"] = "JavaHelper";
		objKernelLibs[3]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[3]["FILE"] = "ZAnt.basic.zBasic.JavaHelperZZZ.js";
		
		objKernelLibs[4] = new Object();
		objKernelLibs[4]["ALIAS"] = "ArrayStringHandling";
		objKernelLibs[4]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[4]["FILE"] = "ZAnt.basic.zBasic.util.datatype.string.StringArrayZZZ.js";
		
		objKernelLibs[5] = new Object();
		objKernelLibs[5]["ALIAS"] = "HandleDebug";
		objKernelLibs[5]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[5]["FILE"] = "ZAnt.basic.zBasic.HandleDebugZZZ.js";
		
		objKernelLibs[6] = new Object();
		objKernelLibs[6]["ALIAS"] = "DatatypeHandling";
		objKernelLibs[6]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[6]["FILE"] = "ZAnt.basic.zBasic.util.DatatypeZZZ.js";
		
		objKernelLibs[7] = new Object();
		objKernelLibs[7]["ALIAS"] = "ArrayHandling";
		objKernelLibs[7]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[7]["FILE"] = "ZAnt.basic.zBasic.util.ArrayZZZ.js";
		
		objKernelLibs[8] = new Object();
		objKernelLibs[8]["ALIAS"] = "StringHandling";
		objKernelLibs[8]["DIRECTORY"] = sDirSubDefault; 
		objKernelLibs[8]["FILE"] = "ZAnt.basic.zBasic.util.datatype.string.StringZZZ.js";

		//REM Das Original aus dem grundlegendne Import-Tryout.
		//eval('' + org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader( 'tryoutAnt_ImportJavascriptJs.js' ) ) );
		for (var i = 0; i < objKernelLibs.length; i++) { 									
			//print("Lies Kernel Ant Js Bibliothek ein: '" + objKernelLibs[i]["ALIAS"]+"'"); 
			//for (var objEigenschaft in objKernelLibs[i]) {
			//	print("Eigenschaft: '" + objEigenschaft + " = " + objKernelLibs[i][objEigenschaft] + "'"); 							
			//}	
			
			//Merke: basedir im Ant-Projekt ist auf ".." gesetzt.
			//print("'../" + objKernelLibs[i]["DIRECTORY"] + "/" + objKernelLibs[i]["FILE"] +"'");																			
			try{
				objKernelLibs[i]["LOADINGSTRING"] = "org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader(\"../"+objKernelLibs[i]["DIRECTORY"] + "/" + objKernelLibs[i]["FILE"]+"\"))";
				//print("objKernelLibs["+i+"][LOADINGSTRING] = " + objKernelLibs[i]["LOADINGSTRING"]);
				objKernelLibs[i]["LOADER"] = eval(objKernelLibs[i]["LOADINGSTRING"]); //Der LOADER kann dann mit eval(objKernelLibs[i]["LOADER"]) ausgeführt werden
			}catch(errEval){
				//#### SIMPLES ERROR HANDLING FUER KONKRETE BIBLIOTHEK #######
				print("Fehler gefangen fuer JS-Bibliothek: "+objKernelLibs[i]["ALIAS"] + " - "  + errEval);			
			}
			//Gibt den ganzen Inhalt der Bibliothek aus: print("Loader: " + objKernelLibs[i]["LOADER"]);
			//Das ist dann etwas zuviel und funktioniert nicht... objKernelLibs[i]["CODEEXECUTED"] = eval('' + eval(objKernelLibs[i]["LOADER"])) ;						
			//Das ist dann etwas zuviel und funktioniert nicht... objKernelLibs[i]["CODEEXECUTED"] = eval(objKernelLibs[i]["LOADER"]) ;
		}
		//objControl["KERNELLIBS"]=objKernelLibs; //Ich hab mich dazu entschlossen das Kernelobjekt eingeständig zu machen.
		bReturnControl=true;
		sReturnControl=sScript+"Alles o.k.";
		bReturn=true;
	}catch(err){	
		//#### SIMPLES ERROR HANDLING #######
		print("Fehler gefangen usedKernelAntLibs: " + err);
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;
	return bReturn;
}
			
//####################################################################################
//BEISPIEL: SO WERDEN DIE BIBLIOTHEKEN ALLE GELADEN INNERHALB EINER FUNKTION:
//          ABER: Merke dass in den einfachen Scriptfunktionen NICHT ebenfalls ein Laden gemacht werden darf.
function loadKernelAntJsExample(objKernelLibs, objControl){			
	var sScript = "loadKernelAntJsExample: ";
	
	//Führe ein eval über die Kernelfunktionen aus und lies sie damit ein. 
	//Problem: Die Funktionen stehen nur in der aufrufenden Funktion zur Verfügung, in der das eval gemacht wurde.
	var bReturn=false; 
	var bReturnControl=false;
	var sReturnControl="Fehler";						
	try{	
		print("#######################");
		//if(objControl["KERNELLIBS"]==undefined || objControl["KERNELLIBS"]==null){ //Es ist günstiger das KernelObj eigenständig zu halten.
		if(objKernelLibs==undefined || objKernelLibs==null){
			print("Keine Kernel Ant Js Libs uebergeben zum Laden");
		} else {
			//var objKernelLibs = objControl["KERNELLIBS"];
			if(objKernelLibs.length==0 || objKernelLibs.length==undefined){
				print(sScript+"Keine Kernel Ant Js Libs vorhanden zum Laden");
			} else {
				print(sScript+"Loading Kernel Ant Js Libs: " + objKernelLibs.length);
				for (var i = 0; i < objKernelLibs.length; i++) { 	
					//print("Lib: " + objKernelLibs[i]["ALIAS"]);					
					//Gibt den ganzen Inhalt der Bibliothek aus: print("Loader: " + objKernelLibs[i]["LOADER"]);
					
					//Beispiel aus dem Tryout:
					//eval('' + org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader( 'tryoutAnt_ImportJavascriptJs.js' ) ) );
					
					//ALSO: Wenn der Loader nicht funktioniert hier den Pfad nachbauen.
					//eval('' + org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader( '../objKernelLibs[i]["DIRECTORY"]/objKernelLibs[i]["FILE"]')));//Syntax für Dateinamen ist falsch
					
					//var spath = "../" + objKernelLibs[i]["DIRECTORY"] + "/" + objKernelLibs[i]["FILE"];
					//eval('' + org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader('" + spath + "')));//file not found exception spath!!
					
					//Man muss 2mal eval kombinieren, um den Loader-String einzusetzen.
					//org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader(spath)); //So wird die datei gefunden
					//eval('' + org.apache.tools.ant.util.FileUtils.readFully(new java.io.FileReader(spath)) ); //So werden die Funktionen aus der gefundene Datei bereitgestellt
					//funktioniert:eval('' + eval(objKernelLibs[i]["LOADER"])); //funktioniert
					//eval(objKernelLibs[i]["CODEEXECUTED"]);   //funktioniert NICHT, ist dann ein bissl zuviel
					
					//funktioniert: 
					eval(''+objKernelLibs[i]["LOADER"]); //funktioniert, so wird der Code eingebunden.
					
					//objKernelLibs[i]["CODEEXECUTED"] = eval(objKernelLibs[i]["LOADER"]); //funktioniert
					//funktioniert nicht: eval(objKernelLibs[i]["CODEEXECUTED"]); //functioniert nicht, ist ein bissl zuviel.								
				}
				
				//print("Loader 0: " + objKernelLibs[0]["LOADER"]);//Gibt die ganze Bibliothek aus.
				//eval(''+objKernelLibs[0]["LOADER"]);
				
					//Nach dem Einladen der ganzen Bibliotheken: Mal sehn, ob eine tryout-Funktion aus den externen Scripts zur Verfügung steht.
					errorTraced();
			}
		}
		enableJava();//Der Aufruf geht erst nachdem die Kernelbibliotheken geladen wurden				
		print("#######################");
		print("### Versuche errorTraced auszufuehren");
		//mal sehn, ob die letze funktion des externen Scripts zur Verfügung steht.
		errorTraced();
		print("### errorTraced ausgefuehrt");
		print("#######################");
		
		print("#######################");
		print("### Versuche reflectMethodCurrent_Name auszufuehren");
		//mal sehn, ob die reflectMethodCurrent_Name funktion des externen Scripts zur Verfügung steht.
		var objControlCaller = new Object();
		var stemp = reflectMethodCurrent_Name(null, objControlCaller);
		if(!objControlCaller.bReturnControl) throw new Error(sScript + objControlCaller.sReturnControl);					
		print("### reflectMethodCurrent_Name ausgeführt. stemp="+stemp);					
		print("#######################");		
		
		bReturnControl=true;
		sReturnControl=sScript+"Alles o.k.";
		bReturn=true;
	}catch(err){	
		//#### SIMPLES ERROR HANDLING #######
		print("Fehler gefangen: " + err);
		bReturnControl=false;
		sReturnControl=sScript+"Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;
	return bReturn;
}