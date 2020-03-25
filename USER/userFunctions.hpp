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

	class tauchenMitWums {
		file = "USER\functions\tauchenMitWums";
		class tauchenMitWums_startStation {};
		class tauchenMitWums_endStation {};
		class tauchenMitWums_initStation {};
	};
};