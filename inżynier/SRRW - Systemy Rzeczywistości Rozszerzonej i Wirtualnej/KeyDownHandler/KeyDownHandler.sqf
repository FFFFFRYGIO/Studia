#include "\vbs2\headers\function_library.hpp";
#include "\vbs2\headers\dikCodes.hpp"


private ["_fi","_nHamGl","_handled", "_ctrl", "_keypressed", "_shiftKey", "_ctrlKey", "_altKey", "_s",
        "_lib", "_nMode", "_item", "_val", "_bDoIt","_parametry","_parametryArr","_tmp_fi","_tmp_h_gl","_tmp_h_pom","_model"];


_keypressed = _this select 1;
_shiftKey = _this select 2;
_ctrlKey = _this select 3;
_altKey = _this select 4; 
_handled = false;




systemChat format ["KEY:[K-%1][SH-%2][CTRL-%3][ALT-%4]",_keypressed,_shiftKey,_ctrlKey,_altKey];


//same klawisze bez shift ctrl alt
if (!_altKey and !_shiftKey and !_ctrlKey) then {
	//same klawisze bez alt ctrl shift
	
	
	switch (_keypressed) do
			{

				case DIK_H: { 
							//systemChat "Help";
							};
							
				case DIK_W: { 
								keyW = "D";
								
							}; 
				case DIK_NUMPADENTER: { 
							
							};
				case DIK_R: { 
							};
							
				case DIK_G: { 
							};
				case DIK_PRIOR : { 
								systemChat "[Page Up] "; 
							};


				case DIK_NEXT : { 

								systemChat "[Page Down]"; 
								
							};
							
				case DIK_END: { 
							  
							  
							};  												
							
				case DIK_HOME: { 
							};  																		
							
				case DIK_DELETE: { 
							};  												
							
				case DIK_INSERT: { 
							};  																								
							
							
				case DIK_1 : { 
								systemChat "[1]"; 
							};		
							
								
				case DIK_2 : { 
								systemChat "[2]"; 
							};						

				case DIK_3 : { 
								systemChat "[3]"; 
							};								
							
				case DIK_4 : { 
								systemChat "[4]"; 
								
							};	
							
				case DIK_5 : { 
								
							};		

				case DIK_6 : { 

							};	
							
				case DIK_0 : { 
							
							};
                case DIK_UP : {
				    systemChat "[UP]";
                };
 				case DIK_DOWN : {
				    systemChat "[DOWN]";
                };
				case DIK_LEFT : {
				    systemChat "[LEFT]";
					//['lewo'] execVM "przesun.sqf";
								['lewo'] call przesun;
                                                        };
				case DIK_RIGHT : {
								systemChat "[RIGHT]";
                                                        };				
							
			};	
};



if (_altKey) then {

        switch (_keypressed) do
        {

			case DIK_H: { 
						
						
						systemChat "Help";
						  
						};
						
						
			case DIK_Y: { 
						}; // Y 
			case DIK_T: { 
						}; // T
			case DIK_R: { 
						}; // R
						
			case DIK_G: { 
						}; // G
			case DIK_PRIOR : { 
							systemChat "[Alt Page Up] "; 
						};


			case DIK_NEXT : { 

							systemChat "[Alt Page Down]"; 
							
						};
						
			case DIK_END: { 
						  
						  
						};  												
						
			case DIK_HOME: { 
						};  																		
						
			case DIK_DELETE: { 
						};  												
						
			case DIK_INSERT: { 
						};  																								
						
						
			case DIK_1 : { 
							systemChat "[Alt 1]"; 
						};		
						
							
			case DIK_2 : { 
							systemChat "[Alt 2]"; 
						};						

			case DIK_3 : { 
							systemChat "[Alt 3]"; 
						};								
						
			case DIK_4 : { 
							systemChat "[Alt 4]"; 
							
						};	
						
			case DIK_5 : { 
							
						};		

			case DIK_6 : { 

						};	
						
			case DIK_0 : { 
						
						};						
						
		};
};





if(_ctrlKey) then
{

        switch (_keypressed) do
        {
            case DIK_F1:	{ 


						systemChat "Pomoc";	
							
            			}; 
			case DIK_END: { 	 
			
			
            		 }; 
					 
            case DIK_F2: {
            		 };         
            case DIK_F3: { 
					}; // F3
             
            case DIK_F4: { 
						};	
							
            case DIK_F5: { 
						
						 }; 
							
            case DIK_F6: { 
						 };
           	case DIK_F7: {  
						 }; 
            case DIK_F8: { 
						}; // F8
            case DIK_F9: { 
						}; // F9
            
            case DIK_F10: { 
            		   
            		   
					 };            		
                                                
            case DIK_C: { player exec "camera.sqs"; }; // C 
            
			case DIK_L: { 
					[] call endMissionFunction;
					
					};  // L
			


			case DIK_P: { 
						
												
						};  												
						
						
			case DIK_DELETE: { 
						 
						systemChat "[Ctrl DELETE]"; 

						
						};  																		


			
			case DIK_END: { 
						 
						};  												
						
			case DIK_1: { 			
						};
						
			case DIK_HOME: { 
						  
						};  				
			

			
            default
            {
              _item = 0;
            };
        };

    
   
};




_handled;

