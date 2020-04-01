/*
*   Hier können eigene Funktionen eingebunden werden.
*   Ist in CfgFunctions included.
*/

class grad_grandPrix
{
	tag = "grad_grandPrix";
	class common
	{
		file = "USER\functions\common";
		class intro {};
	};
	class util
	{
		file = "USER\functions\util";
		class addTime {};
		class backPorter {};
		class clearCrate {};
		class formatTime {};
		class showTime {};
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
	class mortar 
	{
		file = "USER\functions\mortar";
		class addFireEH {};
		class addMortarAction {};
		class calcShot {};
		class cleanUp {};
		class findPos {};
		class fiveLiner {};
		class logPos {};
		class mortarInit {};
		class mortarMessage {};
		class mortarStop {};
  };
	class erstSchiessenDannFragen {
		file = "USER\functions\erstSchiessenDannFragen";
		class erstSchiessenDannFragen_initStation {};
		class erstSchiessenDannFragen_startStation {};
		class erstSchiessenDannFragen_endStation {};
		class erstSchiessenDannFragen_fillCrate {};
  };
	class pewPew {
		file = "USER\functions\pewPew";
		class pewPew_fillCrate {};
		class pewPew_hitPart {};
		class pewPew_addEh {};
		class pewPew_initStation {};
		class pewPew_startStation {};
		class pewPew_endStation {};
  };
	class tauchenMitWums {
		file = "USER\functions\tauchenMitWums";
		class tauchenMitWums_fillCrate {};
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