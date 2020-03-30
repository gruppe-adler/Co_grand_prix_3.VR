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

	class pewPew {
		file = "USER\functions\pewPew";
		class pewPew_initStation {};
		class pewPew_startStation {};
		class pewPew_endStation {};
	};
};