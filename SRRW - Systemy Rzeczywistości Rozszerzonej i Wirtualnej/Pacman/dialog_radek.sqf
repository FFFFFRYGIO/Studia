// opens the dialog (named "MainDialog")
createDialog "MainDialog";

// then change the control's text to a new message
// ctrlSetText [20000,format["Hello, %1",name player]];
// sleep 1;

// PACMAN MAP CREATION

// 1. Load file:
_map_data = loadFile "pacman_map.txt";

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

// hint format["_map_data_content: %1", _map_data_content];

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
				hint format["_x: %1", _x];
			};
		};

		// 6.2.3. Add object to _map_row_objects list
		_map_row_objects set [count _map_row_objects, _map_row_object];
		
	} forEach _x;
	
	// 6.3. Add full _map_row_objects list to _map_content 
	_map_content set [count _map_content, _map_row_objects];

} forEach _map_data_content;

// 7. Declare empty _ghosts_positions and _pacman_position to store the positions based on map
_ghosts_positions = [];
_pacman_position = [];

// hint format["_map_content: %1", _map_content];

// 8. Render all map cells from _map_content
_rows = (count _map_content);
_cols = (count (_map_content select 0)) - 1;
// hint format["xd = %1", _map_content select 0];
for "_i" from 0 to _rows do {
    for "_j" from 0 to _cols do {
        _cell_idc = _i * _cols + _j + 100;
        _image = ((_map_content select _i) select _j) select 5;
        if (_image == "pacman.paa") then {
            _pacman_position = [_i, _j];
        } elseif (_image == "ghost.paa") then {
            _ghost_position = [_i, _j];
            _ghosts_positions set [count _ghosts_positions, _ghost_position];
        };
        ctrlSetText [_cell_idc, _image];
    };
};




dzialaj = {

}

// 9. Create point counter
_points_count = 0;

// 10. Move pacman
while {true} do {
    hint format["Points count: %1", _points_count];

    _i = _pacman_position select 0;
    _j = _pacman_position select 1;

    _old_cell_idc = _i * _cols + _j + 100;
    _old_position_content = (_map_content select _i) select _j;
    _old_position_content set [3, 0];
    _old_position_content set [5, "area.paa"];

    _key_pressed = _this select 1;

    switch (_key_pressed) do
		{
			case DIK_UP: {
                systemChat "[UP]";
                _i2 = _i - 1;
                _j2 = _j;
			};
			case DIK_DOWN: {
                systemChat "[DOWN]";
                _i2 = _i + 1;
                _j2 = _j;
			};
			case DIK_LEFT: {
                systemChat "[LEFT]";
                _i2 = _i - 1;
                _j2 = _j;
            };
			case DIK_RIGHT: {
                systemChat "[RIGHT]";
                _i2 = _i + 1;
                _j2 = _j;
            };
			default {
				systemChat "wrong input!";
			};
		};

    if (_key == DIK_UP) then {
        systemChat "[UP]";
        _i2 = _i - 1;
        _j2 = _j;
    } elseif (_key == DIK_DOWN) then {
        _i2 = _i + 1;
        _j2 = _j;
    } elseif (_key == DIK_LEFT) then {
        _i2 = _i;
        _j2 = _j - 1;
    } elseif (_key == DIK_RIGHT) then {
        _i2 = _i;
        _j2 = _j + 1;
    }


    _new_position_content = (_map_content select _i2) select _j2;
    _new_cell_idc = _i2 * _cols + _j2 + 100;

    if (_new_position_content select 0 == 1) then {
        // Wall, do nothing
        systemChat "Hit the wall";
    } elseif (_new_position_content select 1 == 1) then {
        // Area, move
        if (_new_position_content select 2 == 1) then {
            // Point, collect it
            _points_count = _points_count + 1;
            _old_position_content set [2, 0];
        };
        _new_position_content set [3, 1];
        _new_position_content set [5, "pacman.paa"];

        (_map_content select _i) set [_j, _old_position_content];
        ctrlSetText [_old_cell_idc, (((_map_content select _i) select _j) select 5)];

        (_map_content select _i2) set [_j, _new_position_content];
        ctrlSetText [_new_cell_idc, (((_map_content select _i2) select _j2) select 5)];

        _pacman_position = [_i2, _j2];
    };
    sleep 0.2;
};

ctrlSetText [20000, "RADEK"];
