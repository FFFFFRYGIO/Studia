#include "\vbs2\headers\function_library.hpp";
#include "\vbs2\headers\dikCodes.hpp"

/// Initialize keyboard input
key_pressed = "NO KEY";
_display = findDisplay 46;
_display displaySetEventHandler ["KeyDown","key_pressed = _this select 1"];

// opens the dialog (named "MainDialog")
createDialog "MainDialog";

_map_file = "pacman_map.txt";
_ImgControl = ((findDisplay 20000) displayCtrl 13);
_ImgControl ctrlSetBackgroundColor [0, 0, 0, 1];
_ImgControl ctrlSetTextColor [0, 0, 0, 1];

// PACMAN MAP CREATION

// 1. Load file:
_map_data = loadFile _map_file;

// 2. Declare basic vars
_map_data_rows = [];
_map_data_content = [];
_map_content = [];

// 3. MapElement class to generate it
/* class MapElement
{
	is_wall = 0;	//[0]
	is_area = 0;	//[1]
	is_point = 0;	//[2]
	is_pacman = 0;	//[3]
	is_ghost = 0;	//[4]
	file_name = "";	//[5]
}; */
_map_element = [0, 0, 0, 0, 0, ""];

// 4. Convert _map_data to _map_rows list
_map_data_rows = [_map_data,  toString[10]] call fn_vbs_splitString;

// 5. Convert _map_data_rows to _map_data_content list of lists of elements
// 5.1. Generate every row
{
	// 5.1.1. Declare empty _map_data_row_elements list
	_map_data_row_elements = [];
	// 5.1.2. Convert _x to _map_data_row_elements list
	_map_data_row_elements = [_x, toString[9]] call fn_vbs_splitString;
	// 5.1.3. Add _map_data_row_elements as an element of _map_data_content;
	_map_data_content set [count _map_data_content, _map_data_row_elements];
} forEach _map_data_rows;

// 6. Generate every cell for map
{
	// 6.1. Declare empty _map_row_objects list
	_map_row_objects = [];

	// 6.2. Fill _map_row_objects with objects
	{
		// 6.2.1. Create object of MapElement
		_map_row_object = _map_element;

		// 6.2.2. Edit object according to its type
		switch (_x) do
		{
			case "W": {
				_map_row_object = [1, 0, 0, 0, 0, "wall.paa"];
			};
			case "A": {
				_map_row_object = [0, 1, 0, 0, 0, "area.paa"];
			};
			case "P": {
				_map_row_object = [0, 1, 1, 0, 0, "point.paa"];
			};
			case "S": {
				_map_row_object = [0, 1, 0, 1, 0, "pacman.paa"];
			};
			case "G": {
				_map_row_object = [0, 1, 0, 0, 1, "ghost.paa"];
			};
			default {
				hint format["Wrong cell input from file: %1", _x];
			};
		};

		// 6.2.3. Add object to _map_row_objects list
		_map_row_objects set [count _map_row_objects, _map_row_object];
		
	} forEach _x;
	
	// 6.3. Add full _map_row_objects list to _map_content 
	_map_content set [count _map_content, _map_row_objects];

} forEach _map_data_content;

// 7. Declare empty variables to store positions and points
_ghosts_positions = [];
_pacman_position = [];
_max_points = 0;
_points_count = 0;


// 8. Render all map cells from _map_content
_rows = (count _map_content);
_cols = (count (_map_content select 0)) - 1;


for "_i" from 0 to _rows do {
    for "_j" from 0 to _cols do {
        _cell_idc = _i * _cols + _j + 100;
        _image = ((_map_content select _i) select _j) select 5;
        if (_image == "pacman.paa") then {
            _pacman_position = [_i, _j];
        } elseif (_image == "ghost.paa") then {
            _ghost_position = [_i, _j];
            _ghosts_positions set [count _ghosts_positions, _ghost_position];
        } elseif (_image == "point.paa") then {
			_max_points = _max_points + 1;
		};
        ctrlSetText [_cell_idc, _image];
    };
};

// END OF PACMAN MAP CREATION

//  Initialize points display
hint format["Points count: %1/%2", _points_count, _max_points];

// Start game
ctrlSetText [12, format["Playing %1", _this select 1]];
playSound ["beginning", true];
sleep 4;

// 9. Move pacman and ghosts
_i2 = 0;
_j2 = 0;
_frame_controller = 0;
while {true} do {

	// Get pacman position
    _i = _pacman_position select 0;
    _j = _pacman_position select 1;

	// Save old pacman position
    _old_cell_idc = _i * _cols + _j + 100;
    _old_position_content = (_map_content select _i) select _j;
    _old_position_content set [3, 0];
    _old_position_content set [5, "area.paa"];

	// Wait for key to move, specify pacman rotation for move
	_rotation = 0;
	_break = 0;
	while {_break == 0} do {
		switch (key_pressed) do {
			case DIK_UP: {
                systemChat "[UP]";
                _i2 = _i - 1;
                _j2 = _j;
				_break = 1;
				key_pressed = "NO KEY";
				_rotation = 270;
			};
			case DIK_DOWN: {
                systemChat "[DOWN]";
                _i2 = _i + 1;
                _j2 = _j;
				_break = 1;
				key_pressed = "NO KEY";
				_rotation = 90;
			};
			case DIK_LEFT: {
                systemChat "[LEFT]";
                _i2 = _i;
                _j2 = _j - 1;
				_break = 1;
				key_pressed = "NO KEY";
				_rotation = 180;
            };
			case DIK_RIGHT: {
                systemChat "[RIGHT]";
                _i2 = _i;
                _j2 = _j + 1;
				_break = 1;
				key_pressed = "NO KEY";
				_rotation = 0;
            };
		};
	};

	// Execute move
	
	if (_j2 == -1 or _j2 == _cols) then {
		// Out of bound, go to another side of map
		if (_j2 == -1) then {_j2 = _cols - 1};
		if (_j2 == _cols) then {_j2 = 0};
	};
	
	_new_position_content = (_map_content select _i2) select _j2;
    _new_cell_idc = _i2 * _cols + _j2 + 100;
	_ImgControl = 0;
	
	if (_frame_controller == 0) then {
		_new_position_content set [5, "pacman.paa"];
		_frame_controller = 1;
	}
	else {
		_new_position_content set [5, "pacman2.paa"];
		_frame_controller = 0;
	};
	
    if (_new_position_content select 0 == 1) then {
        // Wall, do nothing
		_ImgControl = ((findDisplay 20000) displayCtrl _old_cell_idc);
		_old_position_content set [5, _new_position_content select 5];
		(_map_content select _i) set [_j, _old_position_content];
		ctrlSetText [_old_cell_idc, ((_map_content select _i) select _j) select 5];
        systemChat "Hit the wall";
		
    } elseif (_new_position_content select 1 == 1) then {
        // Area, move
        if (_new_position_content select 2 == 1) then {
            // Point, collect it
            _points_count = _points_count + 1;
			playSound ["chomp", true];
			if (_points_count == _max_points) then {
				// When all points are collected, finish the game
				ctrlSetText [12, format["You Won, %1!!!", _this select 1]];
				sleep 1;
			};
			
			// Remove point from new position
            _new_position_content set [2, 0];
        };
		
		// Set pacman on new position
        _new_position_content set [3, 1];

        (_map_content select _i) set [_j, _old_position_content];
        ctrlSetText [_old_cell_idc, (((_map_content select _i) select _j) select 5)];

        (_map_content select _i2) set [_j2, _new_position_content];
        ctrlSetText [_new_cell_idc, (((_map_content select _i2) select _j2) select 5)];

		_ImgControl = ((findDisplay 20000) displayCtrl _new_cell_idc);

        _pacman_position = [_i2, _j2];
		
		// Rotate back old cell area
		_ImgControlOld = ((findDisplay 20000) displayCtrl _old_cell_idc);
		_ImgControlOld ctrlSetAngle 0;
		_ImgControlOld ctrlCommit 0;
    };
	
	// Rotate pacman
	_ImgControl ctrlSetAngle _rotation;
	_ImgControl ctrlCommit 0;
	
	// Check collision after pacman move
	{
		if (_x select 0 == _pacman_position select 0 and _x select 1 == _pacman_position select 1) then {
			_death_idc = (_pacman_position select 0) * _cols + (_pacman_position select 1) + 100;
			ctrlSetText [_death_idc, "ghost.paa"];
			_ImgControl ctrlSetAngle 0;
			_ImgControl ctrlCommit 0;
			_ImgControl ctrlSetTextColor [1, 1, 0, 1];
			ctrlSetText [12, format["You Lost!!! SCORE: %1", _points_count*10]];
			sleep 1;
			playSound ["death", true];
			sleep 1000;
			
		};
	} forEach _ghosts_positions;
	
	// Update points
	hint format["Points count: %1/%2", _points_count, _max_points];
	
	// Move ghosts
	{
		_i = _x select 0;
		_j = _x select 1;

		_old_cell_idc = _i * _cols + _j + 100;
		_old_position_content = (_map_content select _i) select _j;
		
		// Remove ghost from old position
		_old_position_content set [4, 0];
		if (_old_position_content select 2 == 1) then {
			_old_position_content set [5, "point.paa"];
		}
		else {
			_old_position_content set [5, "area.paa"];
		};
		
		_i2 = 0;
		_j2 = 0;
		
		// Generate ghost move
		_was_moved = 0;
		_attepts = 10;
		_new_position_content = 0;
		while {_was_moved == 0} do {
			_ghost_move = floor(random 4) ;
			
			switch (_ghost_move) do
			{
				case 0: { // UP
					_i2 = _i - 1; _j2 = _j; 
				};
				case 1: { // DOWN
					_i2 = _i + 1; _j2 = _j; 
				};
				case 2: { // LEFT
					_i2 = _i; _j2 = _j - 1; 
				};
				case 3: { // RIGHT
					_i2 = _i; _j2 = _j + 1; 
				};
				default {
					hint format["Error moving ghost, _ghost_move: %1", _ghost_move];
				};
			};
			
			if (_j2 == -1 or _j2 == _cols) then {
				// Out of bound, go to another side of map
				if (_j2 == -1) then {_j2 = _cols - 1};
				if (_j2 == _cols) then {_j2 = 0};
			};
				
			_new_position_content = (_map_content select _i2) select _j2;
			if (_new_position_content select 0 == 0) then {
				if (_new_position_content select 1 == 1) then {
					if (_new_position_content select 4 == 0) then {
						_was_moved = 1;
					};
				};
			};
			
			_attepts = _attepts - 1;
			
			if (_attepts == 0) then {
				_was_moved = 2;
			};
			
		};
		
		// Execute move if attempts was successfull
		if (_was_moved == 1) then {
			_new_cell_idc = _i2 * _cols + _j2 + 100;

			// Set ghost on new position
			_new_position_content set [4, 1];
			_new_position_content set [5, "ghost.paa"];
			
			(_map_content select _i) set [_j, _old_position_content];
			ctrlSetText [_old_cell_idc, (((_map_content select _i) select _j) select 5)];
	
			(_map_content select _i2) set [_j2, _new_position_content];
			ctrlSetText [_new_cell_idc, (((_map_content select _i2) select _j2) select 5)];
			
			// Update ghost position
			_ghosts_positions set [_forEachIndex, [_i2, _j2]];
		};

	} forEach _ghosts_positions;

    sleep 0.1;
	
	// Check collision after ghosts move
	{
		if (_x select 0 == _pacman_position select 0 and _x select 1 == _pacman_position select 1) then {
			_death_idc = (_pacman_position select 0) * _cols + (_pacman_position select 1) + 100;
			ctrlSetText [_death_idc, "ghost.paa"];
			_ImgControl ctrlSetAngle 0;
			_ImgControl ctrlCommit 0;
			_ImgControl ctrlSetTextColor [1, 1, 0, 1];
			ctrlSetText [12, format["You Lost!!! SCORE: %1", _points_count*10]];
			sleep 1;
			playSound ["death", true];
			sleep 1000;
		};
	} forEach _ghosts_positions;
	
};
