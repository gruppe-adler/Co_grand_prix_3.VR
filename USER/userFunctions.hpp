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
	class mortar 
	{
		file = "USER\functions\mortar";
		class calcShot {};
		class cleanUp {}:
		class findPos {};
		class fiveLiner {};
		class logPos {};
		class mortarInit {};
	};
};