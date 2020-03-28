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
	class planke
	{
		file = "USER\functions\planke";
		class addJumpEHs {};
		class jumpResults {};
		class plankGroupResult {};
		class portToCarrier {};
	};
};