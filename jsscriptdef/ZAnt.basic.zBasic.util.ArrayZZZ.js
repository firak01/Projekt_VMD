//###############################################################
//### ARRAY STRING HANDLING
//###############################################################

		function arrayInitZZZ(objKernelLibs,mySize,objControl){							
			//var sReturn=""; 
			var arrReturn=null;
			var bReturnControl=false;
			var sReturnControl="Fehler";		
			try{	
				//######################################################################################################################			
				//IN JEDER FUNKTION DAS LADERN DER FUNKTIONEN PER EVAL AUSFUEHREN, SONST STEHEND DIE FUNKTIONEN NICHT ZUR VERFUEGUNG	
				//######################################################################################################################				
				if(objKernelLibs==undefined || objKernelLibs==null){
					print("Keine Kernel Ant Js Libs uebergeben.");
				} else {						
					if(objKernelLibs.length==0 || objKernelLibs.length==undefined){
						print("Keine Kernel Ant Js Libs vorhanden zum Laden");
					} else {
						//print("Loading Kernel Ant Js Libs: " + objKernelLibs.length);
						for (var i = 0; i < objKernelLibs.length; i++) { 	
							//print("Lib: " + objKernelLibs[i]["ALIAS"]);					
							//print("LOADINGSTRING: " + objKernelLibs[i]["LOADINGSTRING"]);
							//funktioniert: 
							eval(''+objKernelLibs[i]["LOADER"]); //Loader-String einsetzen.
							//funktioniert nicht, is ein bissl zuviel: eval(objKernelLibs[i]["CODEEXECUTED"]);
							}
						}
					}
				enableJava();//Der Aufruf geht erst nachdem die Kernelbibliotheken geladen wurden	
				var objControlCaller = new Object();
				sScript = reflectMethodCurrent_Name(null, objControlCaller) + ": ";					
				if(!objControlCaller.bReturnControl) throw new Error(sScript + objControlCaller.sReturnControl);
				//print(sScript + "START");								
				//print("######################################################");
					
				//Prüfen, ob mySize eine Zahl ist. 
				//Merke: Ist z.B. die Flaka - Variable nicht oder leer deklariert, kommt hier der Variablenname '${irgendwas}' an.
				//           Das bewirkt, dass dieses '${irgendwas}' als erstes Element in´s Array kommt und das Array sofort die Größe 1 hat, was in dem Fall nicht beabsichtigt ist.
				if(isNumber(mySize)){
					//print("eine Zahl");
					var myArrayReturn = new Array(); //Merke: Egal was man hier als Groesse angiebt [irgendwas] wird als Wert übernommen genauso wie leiglich: irgendwas
					
					if(mySize==0){
						//Analog zu LSZ: ZCraft.Logic.Formula32  wie <#!!FGLSLASH!!#> <#!!FGLDBLSLASH!!#>
						myArrayReturn[0]="<#!!FGLUNDEFINED!!#>";
					}
					if(mySize>=1){
						//Analog zu LSZ: ZCraft.Logic.Formula32  wie <#!!FGLSLASH!!#> <#!!FGLDBLSLASH!!#>
						for(icount=0; icount<=mySize-1; icount++){
							myArrayReturn[icount]="<#!!FGLEMPTY!!#>";
						}												
					}								
				}else{
					//print("KEINE Zahl");
					var myArrayReturn = new Array();

					//Analog zu LSZ: ZCraft.Logic.Formula32  wie <#!!FGLSLASH!!#> <#!!FGLDBLSLASH!!#>
					myArrayReturn[0]="<#!!FGLUNDEFINED!!#>";
				}						

				sReturnControl="Alles o.k.";
				bReturnControl=true;					
				arrReturn=myArrayReturn;			
			}catch(err){	
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
			//return sReturn;
			return arrReturn;
		}