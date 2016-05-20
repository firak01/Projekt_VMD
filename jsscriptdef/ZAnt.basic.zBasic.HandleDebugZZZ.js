//#############################################
//### DEBUGHANDLING
//#############################################		
function debugArray(myArray,objControl){
			var sScript = "debugArray: ";
			var bReturn=false; //Wird hier nicht zurueckgegeben
			var bReturnControl=false;
			var sReturnControl="Fehler";
			try{
		
			//Typausgabe
			print("typeof myarray = " + typeof(myArray));
					
			
			var iSize=0;
			if(Array.isArray(myArray)){
				print("Array uebergeben bekommen");
				iSize = myArray.length;
				print("Arraygroesse="+iSize);
				
				//TODO: Die gleichen Ausgaben wie im KEIN ARRAY Fall.
				//- Werte
			}else{
				print("kein Array uebergeben bekommen.");
				
				var icount=0;					
				if(typeof(myArray)=="object"){
					print("Object uebergeben bekommen.");
					
					if(myLevel>=2){
					//das listet alle Methoden des objekts auf.... scheint ein String zu sein....
					//print("ALLE METHODEN DES OBJEKTS:");
					//for(x in myArray){
					//	print(x);		
					//};	
					
					print("#################################");
					print("ALLE METHODEN UND CODEINHALT DES OBJEKTS:");
					for(xx in myArray){
						print("xx: '"+ xx + "'");		//ABER: Damit bekommt man die Namen der Methoden
						print("zugriff ueber xx: '" + myArray[xx] + "'"); //damit bekommt man codeinhalt der Methoden.
					};
					};//myLevel>=2;
					
					var objControlDebugAsString=new Object();//wichtig: Neues ErrorControl Objekt.
					debugArrayAsString(myArray,objControlDebugAsString);
					if(!objControlDebugAsString.bReturnControl) throw new Error(sScript + objControlDebugAsString.sReturnControl);						
					bReturnControl=objControlDebugAsString.bReturnControl;
					sReturnControl=objControlDebugAsString.sReturnControl;
				}else{
					print("kein Objekt");
					var objControlDebugAsString=new Object();//wichtig: Neues ErrorControl Objekt.
					debugArrayAsString(myArray,objControlDebugAsString);	
					if(!objControlDebugAsString.bReturnControl) throw new Error(sScript + objControlDebugAsString.sReturnControl);						
					bReturnControl=objControlDebugAsString.bReturnControl;
					sReturnControl=objControlDebugAsString.sReturnControl;
				};											
			};			
			bReturn=true;	
			
			}catch(err){	
				//#### SIMPLES ERROR HANDLING #######
				print(sScript+"Fehler gefangen: " + err);
				bReturnControl=false;
				sReturnControl=sScript+"Fehler. " + err;	

				//#### ERROR HANDLING #######
				try{																
					//Wende Funktion an, zur Ermittlung der aktuellen Funktion
					var objControlErrh=new Object();//wichtig: Neues ErrorControl Objekt.										
					var myErrorString = handleError(err,objControlErrh);
					if(!objControlErrh.bReturnControl) throw new Error(sScript + objControlErrh.sReturnControl);										
					bReturnControl = false;
					sReturnControl= myErrorString;				
				}catch(e){
					print(e);					
					bReturnControl=false;
					sReturnControl=sScript+"Fehler im ErrorHandling. "+ e;
				}
			}
			objControl.bReturnControl=bReturnControl;
			objControl.sReturnControl=sReturnControl;			
			return bReturn;
		}
			
		function debugArrayAsString(myArray,objControl){
			var sScript = "debugArrayAsString: ";
			var bReturn=false; //Wird hier nicht zurueckgegeben
			var bReturnControl=false;
			var sReturnControl="Fehler";
			try{
					print("#################################");
					print("myArray ist jetzt leider ein String ='"+ myArray +"'");
					//print("myArray[0]='"+myArray[0]+"'");    //Versuch so auf den Inhalt des Arrays zuzugreifen. ABER FEHLER: java.lang.String has no public instance field or method named "0".
					
					print("splitte diesen String nach Komma.");
					var objectArray = myArray.split(',');						//Merke: Versuche so ein Array zu machen.
					for(x in objectArray){
						print("x: '"+ x + "'");		//ABER: Damit bekommt man die Indizes und nicht die Werte. Also "0","1","2" !!!!	Man erzeugt also damit auch kein Array
					};
										
					print("#################################");
					print("Versuch die Werte auszugeben: ");						
					 for(yy in objectArray){
							print("yy: '"+ yy + "'");		//ABER: Damit bekommt man die Namen der Methoden
							print("zugriff ueber yy: '" + objectArray[yy] + "'"); //BINGO !!!!
						};
					bReturnControl=true;
					sReturnControl=sScript+"Alles o.k.";
					bReturn=true;	
				}catch(err){	
					//#### SIMPLES ERROR HANDLING #######
					print(sScript+"Fehler gefangen: " + err);
					bReturnControl=false;
					sReturnControl=sScript+"Fehler. " + err;	

					//#### ERROR HANDLING #######
					try{																
						//Wende Funktion an, zur Ermittlung der aktuellen Funktion
						var objControlErrh=new Object();//wichtig: Neues ErrorControl Objekt.										
						var myErrorString = handleError(err,objControlErrh);
						if(!objControlErrh.bReturnControl) throw new Error(sScript + objControlErrh.sReturnControl);										
						bReturnControl = false;
						sReturnControl= myErrorString;				
					}catch(e){
						print(e);					
						bReturnControl=false;
						sReturnControl=sScript+"Fehler im ErrorHandling. "+ e;
					}
				}
				objControl.bReturnControl=bReturnControl;
				objControl.sReturnControl=sReturnControl;			
				return bReturn;							
			}