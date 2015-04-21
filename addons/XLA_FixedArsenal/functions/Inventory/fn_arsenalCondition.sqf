/*
	Author: ImperialAlex (Alexander)

	Description:
	Given a classname (item to test) and an object (potentially containing virtualcargo variables), determine if the item is 'allowed' in the context of the object.	

	Parameter(s):
		0: STRING - classname of the item to test	
		1 (OPTIONAL): ARRAY of STRING - whitelist (default: [])
		2 (OPTIONAL): ARRAY of STRING - blacklist (default: [])
		// FUTURE: SIDE WHITELIST?	? (OPTIONAL): ARRAY of INTEGERS - side-whitelist (default [])
		// FUTURE: SIDE BLACKLSIT?  ? (OPTIONAL): ARRAY of INTEGERS - sideblacklist (default [])
		3 (Optional): BOOL - fullVersion toggle. true to allow all items, false to use whitelist. (default: false)	

	Example:
	["arifle_MX_F",["arifle_MX_F"],[],false] call xla_fnc_arsenalCondition;

	Returns:
	BOOL - true if item is allowed, false otherwise.
*/

	private ["_item","_whitelist","_blacklist","_fullVersion"];
	_item = [_this,0,"",[""]] call bis_fnc_param;
	_whitelist = [_this,1,[],[[]]] call bis_fnc_param;
	_blacklist = [_this,2,[],[[]]] call bis_fnc_param;
	_fullVersion = [_this,3,false,[false]] call bis_fnc_param;

	#define NO_SIDE -1
	#define EAST_SIDE 0
	#define WEST_SIDE 1
	#define INDEP_SIDE 2
	#define CIV_SIDE 3
	#define NEUTRAL_SIDE 4
	#define ENEMY_SIDE 5
	#define FRIENDLY_SIDE 6
	#define LOGIC_SIDE 7	

	// current hack to avoid having to deal with side logic:
	_virtualSideCargo = [];
	_virtualSideBlacklist = [];
	
	_XLA_condition = false;
	if (_fullVersion) then {
		_XLA_condition = true;
	} else { 
		private ["_xla_config","_xla_side","_xla_factionstring","_xla_sideallowed"];
		_xla_config = configFile;
		{ 
			if (isClass(configFile / _x / _item)) then	{ 
				_xla_config = configFile / _x / _item;
			};
		}	foreach ["CfgWeapons","CfgVehicles","CfgMagazines","CfgGlasses"];
		if (_xla_config != configFile ) then { 
			_xla_side = NO_SIDE;
			if (isNumber (_xla_config >> "side")) then { 
				_xla_side = getNumber (_xla_config >> "side");
			};
			_xla_factionstring = getText(_xla_config >> "faction");
			if (_xla_factionstring != "" && _xla_factionstring != "Default") then { 
				_configFaction = (configFile / "CfgFactionClasses" / _xla_factionstring);
				if (isNumber (_configFaction >> "side")) then { 
					_xla_side = getNumber (_configFaction >> "side");
				};
			};
			if (isNumber (_xla_config >> "XLA_arsenal_side")) then { 
				_xla_side = getNumber (_xla_config >> "XLA_arsenal_side");
			};
			_xla_sideallowed = ( ((str _xla_side) in _virtualSideCargo ) || ((_virtualSideCargo find "%ALL") >= 0) ) && !( ((str _xla_side) in _virtualSideBlacklist )  || ((_virtualSideBlacklist find "%ALL") >= 0) );
			if (_xla_sideallowed) then { 
				if ( "%ALL" in _blacklist ) then {
					_XLA_condition = false;
					{if (_x == _item) exitWith {_XLA_condition = true;}} forEach _whitelist;
				} else {
					_XLA_condition = true;
					{if (_x == _item) exitWith {_XLA_condition = false;}} forEach _blacklist;
				};
			} else { 
				if ( "%ALL" in _whitelist ) then {
					_XLA_condition = true;
					{if (_x == _item) exitWith {_XLA_condition = false;}} forEach _blacklist;
				} else {
					_XLA_condition = false;
					{if (_x == _item) exitWith {_XLA_condition = true;}} forEach _whitelist;
				};
			};
		} else { 
			_XLA_condition = false;
		};
	};
	_XLA_condition;