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
	class race
	{
		file = "USER\functions\race";
		class addActions {};
		class resetRace {};
		class results {};
		class startRace {};
		class startTimeRecording {};
		class stopTimeRecording {};
	};
};