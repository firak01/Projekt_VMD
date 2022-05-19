//###############################################################
//### ARRAY STRING HANDLING
//###############################################################
		function arrayStringImplodeZZZ(myArrayString,myDelimiter,myiIndexLow,myiIndexHigh,objControl){							
				var sReturn=""; 
				var bReturnControl=false;
				var sReturnControl="Fehler";		
				try{	
				var objControlCaller = new Object();
				var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
				if(!objControlCaller.bReturnControl) throw new Error(objControlCaller.sReturnControl);
				//print(sScript+"START");				
				
				try{					
					var myStringReturn=sReturn;				
					if(myArrayString===undefined){
						//print("myArrayString = undefined");
						bReturnControl = false;
					}else if(myArrayString===null){
						//print("myArrayString = null");			
						bReturnControl = false;
					}else{
						if(myDelimiter===undefined){
							//print("myDelimiter = 'undefined'");
							myStringReturn=myArrayString.join("");
							bReturnControl = false;
						}else if(myDelimiter===''){
							//print("myDelimiter = 'leer'");
							myStringReturn=myArrayString.join("");
							bReturnControl = false;
						}else{	
							//print("myDelimiter = " + myDelimiter);
						
							if(myiIndexLow===undefined){
								myiIndexLow=0;
							}else if(myiIndexLow==null){
								myiIndexLow=0;
							}else if(myiIndexLow<=-1){
								myiIndexLow=0;
							}
							
							//Merke: Versuche so ein 'echtes' Array zu machen, sonst geht man Buchstabe für Buchstabe vor.
							var objectArray = myArrayString.split(',');  
													
							//Hole die Anzahl der Einträge im Array, ggfs. für einen ungueltigen oberen Wert
							myiIndexMax = objectArray.length-1;
							//print("myiIndexMax="+myiIndexMax);
							if(myiIndexHigh===undefined){
								myiIndexHigh=myiIndexMax;
							}else if(myiIndexLow==null){
								myiIndexHigh=myiIndexMax;
							}else if(myiIndexHigh>myiIndexMax){
								myiIndexHigh=myiIndexMax;
							}else if(myiIndexHigh<=-1){
								myiIndexHigh=myiIndexMax;
							}
													
							//Falsch: damit geht man Buchstabe für Buchstabe vor: 
							//for (var i = myiIndexLow, len = myiIndexHigh; i<len; i++){
							//	print("myArrayString[i]="+myArrayString[i]);
							//	myStringReturn+=myArrayString[i];
							//	print("myStringReturn="+myStringReturn);
							//}						 		
							var iIndexCount=-1;
							for(x in objectArray){
								iIndexCount++;
								//print("objectArray[x]="+objectArray[x]);
								if(iIndexCount>=myiIndexLow){
									if(iIndexCount > myiIndexHigh) break;
									if(myStringReturn!="") myStringReturn+=myDelimiter;
									myStringReturn+=objectArray[x];					
									//print("myStringReturn="+myStringReturn);
								}
							}								
						}
					}
									
					sReturnControl="Alles o.k."
					bReturnControl=true;					
					sReturn=myStringReturn;
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
			
		//################################################################
			function arrayStringTrimZZZ(objKernelLibs,myArrayString,objControl){							
				var sReturn=""; 
				var bReturnControl=false;
				var sReturnControl="Fehler";		
				try{	
				var objControlCaller = new Object();
				var sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
				if(!objControlCaller.bReturnControl) throw new Error(sScript + objControlCaller.sReturnControl);
				//print(sScript+"START");				
				
				try{					
					var myStringReturn=sReturn;				
					if(myArrayString===undefined){
						//print("myArrayString = undefined");
						bReturnControl = false;
					}else if(myArrayString===null){
						//print("myArrayString = null");			
						bReturnControl = false;
					}else{
						if(myDelimiter===undefined){
							//print("myDelimiter = 'undefined'");
							myStringReturn=myArrayString.join("");
							bReturnControl = false;
						}else if(myDelimiter===''){
							//print("myDelimiter = 'leer'");
							myStringReturn=myArrayString.join("");
							bReturnControl = false;
						}else{	
							//print("myDelimiter = " + myDelimiter);
						
							if(myiIndexLow===undefined){
								myiIndexLow=0;
							}else if(myiIndexLow==null){
								myiIndexLow=0;
							}else if(myiIndexLow<=-1){
								myiIndexLow=0;
							}
							
							//Merke: Versuche so ein 'echtes' Array zu machen, sonst geht man Buchstabe für Buchstabe vor.
							var objectArray = myArrayString.split(',');  
													
							//Hole die Anzahl der Einträge im Array, ggfs. für einen ungueltigen oberen Wert
							myiIndexMax = objectArray.length-1;
							//print("myiIndexMax="+myiIndexMax);
							if(myiIndexHigh===undefined){
								myiIndexHigh=myiIndexMax;
							}else if(myiIndexLow==null){
								myiIndexHigh=myiIndexMax;
							}else if(myiIndexHigh>myiIndexMax){
								myiIndexHigh=myiIndexMax;
							}else if(myiIndexHigh<=-1){
								myiIndexHigh=myiIndexMax;
							}
													
							//Falsch: damit geht man Buchstabe für Buchstabe vor: 
							//for (var i = myiIndexLow, len = myiIndexHigh; i<len; i++){
							//	print("myArrayString[i]="+myArrayString[i]);
							//	myStringReturn+=myArrayString[i];
							//	print("myStringReturn="+myStringReturn);
							//}						 		
							var iIndexCount=-1;
							for(x in objectArray){
								iIndexCount++;
								//print("objectArray[x]="+objectArray[x]);
								if(iIndexCount>=myiIndexLow){
									if(iIndexCount > myiIndexHigh) break;
									if(myStringReturn!="") myStringReturn+=myDelimiter;
									myStringReturn+=objectArray[x];					
									//print("myStringReturn="+myStringReturn);
								}
							}								
						}
					}
									
					sReturnControl="Alles o.k."
					bReturnControl=true;					
					sReturn=myStringReturn;
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
			
			
			