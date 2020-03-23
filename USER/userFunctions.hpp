/*
*   Hier können eigene Funktionen eingebunden werden.
*   Ist in CfgFunctions included.
*/

class grad_grandPrix
{
	tag = "grad_grandPrix";
	class util
	{
		file = "USER\functions\util";
		class addTime {};
		class formatTime {};
		class startTimer {};
		class stopTimer {};
	};
	class gottesFinger
	{
		file = "USER\functions\gottesFinger";
		class gottesFinger_cancel {};
		class gottesFinger_end {};
		class gottesFinger_guess {};
		class gottesFinger_hintGroup {};
		class gottesFinger_initStation {};
		class gottesFinger_openDisplay {};
		class gottesFinger_prepNextPosition {};
		class gottesFinger_start {};
	};
};