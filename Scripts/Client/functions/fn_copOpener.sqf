/*
 police sender, open gates from inside the car (only for cops) 
 by Insane
 www.tdc-clan.eu
*/

{
	if (_x animationPhase "Door_1_rot" == 1) then {
		_x animate ["Door_1_rot", 0];
		_x animate ["Door_2_rot", 0];
	} 
	else 
	{
		_x animate ["Door_1_rot", 1];
		_x animate ["Door_2_rot", 1];
	};
	
} forEach (nearestObjects [player, ["Land_BarGate_F", "Land_Net_Fence_Gate_F", "Land_City_Gate_F"], 10]);