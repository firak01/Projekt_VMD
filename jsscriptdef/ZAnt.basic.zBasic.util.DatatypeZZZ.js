//###############################################################
//### DATATYPE HANDLING
//###############################################################
	function isNumber(n) {
			return !isNaN(parseFloat(n)) && isFinite(n);
	}
	
	function encodeMyHtml(htmlToEncode) {
		//TODO: In den JSZ Kernel bringen
		 var encodedHtml = escape(htmlToEncode);
		 encodedHtml = encodedHtml.replace(/\//g,"%2F");
		 encodedHtml = encodedHtml.replace(/\?/g,"%3F");
		 encodedHtml = encodedHtml.replace(/=/g,"%3D");
		 encodedHtml = encodedHtml.replace(/&/g,"%26");
		 encodedHtml = encodedHtml.replace(/@/g,"%40");
		 return encodedHtml;
		 //merke: mit unescape(...) bekommt man den korrekten String wieder zurück.
	   }
			
						
	function convertBoolToInt()
			{
				//TODO: Diese Funktion in JSZ-Kernel Bibliotheken packen. 
				//TODO: In einer entsprechenden Scriptdef Funktion nutzen.
				var testBool = true;
				result = (testBool)?1:0;
				//alert(result);
				return result;
			}		
		
		
/*Prüft, ob etwas ein Array ist */
function isArray(obj) {
   if (obj.constructor.toString().indexOf("Array") == -1)
      return false;
   else
      return true;
}

    //aus JSZ-Kernel		
	function isEmpty( objIn ) {
	if ( null == objIn || "" == objIn ) {
		 return true;
		  }
		  
	 if(isArray(objIn)){
	 	if(objIn.length<= -1 ){
	 		return true;
	 	}
	 }	  
	 return false;
 }