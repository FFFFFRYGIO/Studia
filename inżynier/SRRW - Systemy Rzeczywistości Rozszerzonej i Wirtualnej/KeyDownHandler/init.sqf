#include "\vbs2\headers\dikCodes.hpp"
KeyDownHandler = compile (preprocessFile ("KeyDownHandler.sqf"));
_display = findDisplay 46;
_display displaySetEventHandler ["KeyDown","_this call KeyDownHandler"];




endMissionFunction = {                
 
  endMission 'END1';  
  true	
}; 

execVM "dialog.sqf";