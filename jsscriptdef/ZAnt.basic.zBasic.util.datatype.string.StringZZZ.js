//###############################################################
//### STRING HANDLING
//###############################################################
//äquivalent zu JSZ - Kernel

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
	try{	
		var objControlCaller = new Object();
		var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);

		try{
			arr = sourceStr.split(keyStr);
			arr.pop();		//entfernt das letzte Element aus dem Array
			//arr.shift();		//entfernt das erste Element aus dem Array
			sReturn = (keyStr==null | keyStr=='') ? '' : arr.join();
			print("sourceStr | keyStr | sReturn = '" + sourceStr + "' | '" + keyStr + "' | '" + sReturn + "'");
			sReturnControl="Alles o.k."
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
	return sReturn;			
}

 //aus JSZ - Kernel 
function getStrLeftStr(sourceStr, keyStr,objControl){
	var sReturn="";
	var bReturnControl=false;
	var sReturnControl="Fehler";		
	try{	
		var objControlCaller = new Object();
		var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
		if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);

		try{
			sReturn = (sourceStr.indexOf(keyStr) == -1 | keyStr=='') ? '' : sourceStr.split(keyStr)[0];
		
			sReturnControl="Alles o.k."
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
	return sReturn;			
}