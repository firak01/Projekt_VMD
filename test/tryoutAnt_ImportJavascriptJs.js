function tryoutAnt_ImportJavascriptV01(myValue){
	print("################################");
	print("### START: externes JavaScripts V01 ###");
	print("################+++++###########");
	
	
	print("emfangener Parameter: " + myValue);
	
	print("################################");
	print("### ENDE: externes JavaScripts V01###");
	print("################+++++###########");
	
	return true;
}

function tryoutAnt_ImportJavascriptV02(myValue){
	print("################################");
	print("### START: externes JavaScripts V02 ###");
	print("################+++++###########");
	
	
	print("emfangener Parameter: " + myValue);
	
	print("################################");
	print("### ENDE: externes JavaScripts V02 ###");
	print("################+++++###########");
	
	return true;
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