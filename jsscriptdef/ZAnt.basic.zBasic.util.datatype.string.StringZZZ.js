//###############################################################
//### STRING HANDLING
//###############################################################
//äquivalent zu JSZ - Kernel

//Merke: So bindet man per Prototype erzeugte, die Klassen erweiternde Methoden in dieses CDATA-Konstrukt ein.   
String.prototype.count = function(lit, cis) {
	//lit is the string to search for ( such as 'ex' ), and 
	//cis is case-insensitivity, defaulted to false, it will allow for choice of case insensitive matches.
	var iReturn=-1;
	try{	
		//Merke: Zumindest unter Java 7 kann kein Funktionsname ermittelt werden, wenn die Funktion per Prototype hinzugefuegt wurde.
		var objControlCaller = new Object();
		var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);

		var sScript = "String.prototype.count: "; //Hier zur Identifizierung hart vorgeben.
		try{
			var m = this.toString().match(new RegExp(lit, ((cis) ? "gi" : "g")));
			//print(sScript + "TTTTTESTEST"); //Print Ausgaben vor dem RETURN
			
			iReturn = (m != null) ? m.length : 0;
		}catch(err){	
			//#### SIMPLES ERROR HANDLING #######
			print(sScript+"Fehler gefangen: " + err);
			bReturnControl=false;
			sReturnControl=sScript+"Fehler. "+ err;					
		}				
	}catch(err){	
		//#### SIMPLES ERROR HANDLING #######
		print("Fehler (vor Funktionsnamensermittlung) gefangen: " + err);
		bReturnControl=false;
		sReturnControl="Fehler. "+ err;					
	}	
	return iReturn;
}


//TODO: In den JSZ Kernel bringen
function encodeMyHtml(htmlToEncode) {
	var encodedHtml = escape(htmlToEncode);
	encodedHtml = encodedHtml.replace(/\//g,"%2F");
	encodedHtml = encodedHtml.replace(/\?/g,"%3F");
	encodedHtml = encodedHtml.replace(/=/g,"%3D");
	encodedHtml = encodedHtml.replace(/&/g,"%26");
	encodedHtml = encodedHtml.replace(/@/g,"%40");
	return encodedHtml;
	//merke: mit unescape(...) bekommt man den korrekten String wieder zurück.
}

//@LeftBack equivalent, !!! casesensitive
function getStrLeftBackStr(sourceStr,keyStr,objControl){
	var sReturn=""; 
	var bReturnControl=false;
	var sReturnControl="Fehler";
	var bReturnChanged=null;	
	try{	
		var objControlCaller = new Object();
		var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);

		try{
			//sReturn = (sourceStr.indexOf(keyStr) == -1 | keyStr=='') ? '' : sourceStr.split(keyStr)[0];
			//if(sourceStr==sReturn){ bReturnChanged=false } else { bReturnChanged=true};
			
			arr = sourceStr.split(keyStr)
			arr.pop();
			//arr.shift();		//entfernt das erste Element aus dem Array
			//20160105: so unterschlaegt man aber keyStr: return (keyStr==null | keyStr=='') ? '' : arr.join();		
			//                     Darum in einer Schleife zusammenbauen		
			if(arr.length>=2){
				for (index = 0; index < arr.length-1; ++index) {
					sReturn=sReturn+arr[index]+keyStr;
				}
			}
			sReturn=sReturn+arr[arr.length-1];	
			
			if(sourceStr==sReturn){ bReturnChanged=false } else { bReturnChanged=true};			
			sReturnControl="Alles o.k.";
			bReturnControl=true;					
		}catch(err){	
			//#### SIMPLES ERROR HANDLING #######
			print(sScript+"Fehler gefangen: " + err);
			bReturnControl=false;
			sReturnControl=sScript+"Fehler. "+ err;					
		}
				
	}catch(err){	
		//#### SIMPLES ERROR HANDLING #######
		print("Fehler (vor Funktionsnamensermittlung) gefangen: " + err);
		bReturnControl=false;
		sReturnControl="Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;
	objControl.bReturnChanged=bReturnChanged;
	return sReturn;			
}

 //aus JSZ - Kernel 
function getStrLeftStr(sourceStr, keyStr,objControl){
	var sReturn="";
	var bReturnControl=false;
	var sReturnControl="Fehler";		
	var bReturnChanged=null;
	try{	
		var objControlCaller = new Object();
		var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
		//print("TEST 20190106: sScript="+sScript);
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);		
		try{
			sReturn = (sourceStr.indexOf(keyStr) == -1 | keyStr=='') ? '' : sourceStr.split(keyStr)[0];
			if(sourceStr==sReturn){ bReturnChanged=false } else { bReturnChanged=true};
			sReturnControl="Alles o.k.";
			bReturnControl=true;					
		}catch(err){	
			//#### SIMPLES ERROR HANDLING #######
			print(sScript+"Fehler gefangen: " + err);
			bReturnControl=false;
			sReturnControl=sScript+"Fehler. "+ err;					
		}
				
	}catch(err){	
		//#### SIMPLES ERROR HANDLING #######
		print("Fehler (vor Funktionsnamensermittlung) gefangen: " + err);
		bReturnControl=false;
		sReturnControl="Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;
	objControl.bReturnChanged=bReturnChanged;
	return sReturn;			
}

  //aus JSZ - Kernel   
function getStrRightStr(sourceStr, keyStr, objControl){
	var sReturn="";
	var bReturnControl=false;
	var sReturnControl="Fehler";
	var bReturnChanged=null;
	try{
		var objControlCaller = new Object();
		var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
		
		try{
			var idx = sourceStr.indexOf(keyStr);
			sReturn = (idx == -1 | keyStr=='') ? '' : sourceStr.substr(idx+keyStr.length);
			if(sourceStr==sReturn){ bReturnChanged=false } else { bReturnChanged=true};
			sReturnControl="Alles o.k.";
			bReturnControl=true;	
		}catch(err){	
			//#### SIMPLES ERROR HANDLING #######
			print(sScript+"Fehler gefangen: " + err);
			bReturnControl=false;
			sReturnControl=sScript+"Fehler. "+ err;					
		}
	}catch(err){	
		//#### SIMPLES ERROR HANDLING #######
		print("Fehler (vor Funktionsnamensermittlung) gefangen: " + err);
		bReturnControl=false;
		sReturnControl="Fehler. "+ err;					
	}
	objControl.bReturnControl=bReturnControl;
	objControl.sReturnControl=sReturnControl;
	objControl.bReturnChanged=bReturnChanged;
	return sReturn;
}
