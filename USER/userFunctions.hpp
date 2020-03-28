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

	class erstSchiessenDannFragen {
		file = "USER\functions\erstSchiessenDannFragen";
		class erstSchiessenDannFragen_initStation {};
		class erstSchiessenDannFragen_startStation {};
		class erstSchiessenDannFragen_endStation {};
	};
};