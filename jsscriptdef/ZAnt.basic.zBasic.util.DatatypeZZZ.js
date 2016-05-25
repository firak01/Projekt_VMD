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
			
			
			