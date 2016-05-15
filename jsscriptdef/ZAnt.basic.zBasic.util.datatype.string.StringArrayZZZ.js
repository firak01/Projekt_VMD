		//###############################################################
		//### ARRAY STRING HANDLING
		//###############################################################
		function arrayStringImplodeZZZ(objKernelLibs,myArrayString,myDelimiter,myiIndexLow,myiIndexHigh,objControl){			
				var sScript = "arrayStringImplodeZZZ: ";
				print(sScript+"START");
				
				//Führe ein eval über die Kernelfunktionen aus und lies sie damit ein. 
				//Problem: Die Funktionen stehen nur in der aufrufenden Funktion zur Verfügung, in der das eval gemacht wurde.
				var sReturn=""; 
				var bReturnControl=false;
				var sReturnControl="Fehler";						
				try{	
					print("#######################");			

					print ("hier imploden");
					var objControlCaller=new Object();
					//objControlCaller["KERNELLIBS"]=objControl["KERNELLIBS"]; //DARUM WIRD DAS objKernelLibs eigenständg gehalten.
					//Obwohl man hiermit das Laden der JS-Funktionen durchführt, stehen die Funktionen an dieser Stelle nicht zur Verfügung. Daher explizit hier mit eval die Funktionen laden.
					//loadKernelAntJsExampleXX(objKernelLibs, objControlCaller); 
					//if(!objControlCaller.bReturnControl) throw new Error(sScript + objControlCaller.sReturnControl);
																
					print(sScript+"### versuche errorTraced HIER auszuführen");
					errorTraced();
					print("### errorTraced ausgeführt");
					
					print("#######################");
					print(sScript+"### Versuche reflectMethodCurrent_Name auszufuehren");
					//mal sehn, ob die reflectMethodCurrent_Name funktion des externen Scripts zur Verfügung steht.
					var objControlCaller = new Object();
					var stemp = reflectMethodCurrent_Name(null, objControlCaller);					
					if(!objControlCaller.bReturnControl) throw new Error(sScript + objControlCaller.sReturnControl);
					print("### reflectMethodCurrent_Name ausgeführt. stemp="+stemp);					
					print("#######################");	
											
					var sScript = reflectMethodCurrent_Name(null, objControlCaller);										
					sScript=sScript+": ";
					sReturnControl=sScript+"Fehler";		
					print("Name der aktuellen Funktion: "+sScript);
					
				
					sReturnControl="Alles o.k."
					bReturnControl=true;
		
		
					if(myArrayString===undefined){
						//print("myString = undefined");
						bReturnControl = false;
					}else if(myArrayString===null){
						//print("myString = null");			
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

					print("#######################");					
				
					var myStringReturn="xxxx";
					sReturn=myStringReturn;
				}catch(err){	
					//#### SIMPLES ERROR HANDLING #######
					print(sScript+"Fehler gefangen: " + err);
					bReturnControl=false;
					sReturnControl=sScript+"Fehler. "+ err;					
				}
				objControl.bReturnControl=bReturnControl;
				objControl.sReturnControl=sReturnControl;
				return sReturn;
			}