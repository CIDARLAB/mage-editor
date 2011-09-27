package org.jbei.registry.models
{
	[Bindable]
	/**
	 * @author Samir Ahmed
	 * */
	public class mageProperties
	{
		/* Data Types in mageProperties */
		
		// Input Parameters
		private var _oligo_size:int = 90;
		private var _dg_thresh:int = -20;
		private var _mloc_dft:int = 45;
		private var _mloc_max:int = 15;
		private var _addthiol:int = 0;
		private var _calc_replic: Boolean = true;
		
		
		
		// Input Target Records
		private var _count : int;
		private var _start : Array;
		private var _end : Array;
		private var _mutation : Array;
		private var _replichore : Array;
		private var _geneName : Array;
		private var _sense : Array;
		private var _sequence : Array;
		
		// Result Data Members
		
		private var _mageTextResults:String;
		
		// Constructor
		public function mageProperties()
		{
			_count = 0;
			_start = new Array();
			_end = new Array();
			_mutation =  new Array();
			_replichore = new Array();
			_geneName = new Array();
			_sense = new Array();
			_sequence = new Array();
			
		}
		
		// Properties
		public function getoligo_size():int
		{
			return _oligo_size;
		}
		
		public function setoligo_size(value:int):void
		{
			_oligo_size = value;
		}
		
		public function getdg_thresh():int
		{
			return _dg_thresh;
		}
		
		public function setdg_thresh(value:int):void
		{
			_dg_thresh = value;
		}
		
		public function getmloc_dft():int
		{
			return _mloc_dft;
		}
		
		public function setmloc_dft(value:int):void
		{
			_mloc_dft = value;
		}
		
		public function getmloc_max():int
		{
			return _mloc_max;
		}
		
		public function setmloc_max(value:int):void
		{
			_mloc_max = value;
		}
		
		public function getaddthiol():int
		{
			return _addthiol;
		}
		
		public function setaddthiol(value:int):void
		{
			_addthiol = value;
		}
		
		public function getcalc_replic():Boolean
		{
			return _calc_replic;
		}
		
		public function setcalc_replic(value:Boolean):void
		{
			_calc_replic = value;
		}
		
		public function set MageTextResults(_mtr : String): void {
			this._mageTextResults = _mtr;
		}
		
		public function  get MageTextResults(): String {
			return this._mageTextResults;
		}
		
		public function Record(		
			geneName : String,
			start : int,
			end : int,
			mutation : String,
			replichore : String,
			sense : String,
			sequence : String
		)
		{	
			// Increment count
			_count = _count + 1;
			
			// record the remainder of the results
			_geneName[_count] = geneName;
			_sense[_count] = replichore;
			_replichore[_count] = replichore;
			_start[_count] = start;
			_end[_count] = end;
			_mutation[_count] = mutation;
			_sequence[_count] = sequence;
			
		}
		
	}
	
}