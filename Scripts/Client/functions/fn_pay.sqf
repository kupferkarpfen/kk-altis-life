// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// [ amount, type, simulate ]
//
// - amount: amount to pay
// - type: 0 = cash or atm (default) / 1 = cash / 2 = atm
// - simulate: false = pay (default) / true = check only if paying is possible

private _amount = param[ 0, -1, [0] ];
private _type = param[ 1, 0, [0] ];
private _simulate = param[ 2, false, [false] ];

if( _amount < 0 ) exitWith {
    [format["<CERROR> %1 (%2) called fn_pay incorrectly: %3", profileName, getPlayerUID player, _this]] remoteExec ["XY_fnc_log", 2];
};

if( _amount isEqualTo 0 ) exitWith { true };

private _fncPay = switch ( true ) do {
    case( _type <= 1 && { XY_CC >= _amount }): { { XY_CC = XY_CC - _this; } };
    case( (_type isEqualTo 0 || _type isEqualTo 2) && { XY_CA >= _amount } ): { { XY_CA = XY_CA - _this; } };
    case( _type isEqualTo 0 && { XY_CC + XY_CA >= _amount } ): { { XY_CA = XY_CA + XY_CC; XY_CC = 0; XY_CA = XY_CA - _this; } };
    default { nil };
};

if( isNil "_fncPay" ) exitWith { false };

if( !(_simulate) ) then {
    _amount call _fncPay;
    call XY_fnc_save;
};

true;