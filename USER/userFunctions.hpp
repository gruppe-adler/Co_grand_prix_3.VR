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
	class tauchenMitWums {
		file = "USER\functions\tauchenMitWums";
		class tauchenMitWums_startStation {};
		class tauchenMitWums_endStation {};
		class tauchenMitWums_initStation {};
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
	class planke
	{
		file = "USER\functions\planke";
		class addJumpEHs {};
		class jumpResults {};
		class plankGroupResult {};
		class portToCarrier {};
	};
};