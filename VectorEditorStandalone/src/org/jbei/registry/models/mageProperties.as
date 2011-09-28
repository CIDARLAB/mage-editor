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
		
		// New Queued Record info
		public var _nstart : int;
		public var _nend : int;
		public var _nmutation : String;
		public var _nreplichore : String;
		public var _ngeneName : String;
		public var _nsense : String;
		public var _nsequence : String;
		
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
		
		public function get count():int 
		{
			return this._count;
		}
		
		public function get geneName() :Array
		{
			return _geneName;
		}
		
		public function get start() : Array
		{
			return this._start;
		}
		
		public function get end() : Array
		{
			return this._end;
		}
		
		public function get mutation() : Array
		{
			return this._mutation;
		}

		public function get replichore(): Array
		{
			return this._replichore;
		}
		
		public function get sense(): Array 
		{
			return this._sense;
		}
		
		public function get sequence(): Array
		{
			return this._sequence;
		}
		
		public function newRecord(	
			geneName : String,
			start : int,
			end : int,
			mutation : String,
			replichore : String,
			sense : String,
			sequence : String
		) : void
		{	
			// record the remainder of the results
			_geneName[_count] = geneName;
			_sense[_count] = sense;
			_replichore[_count] = replichore;
			_start[_count] = start;
			_end[_count] = end;
			_mutation[_count] = mutation;
			_sequence[_count] = sequence;
			
			// Increment count
			_count = _count + 1;
		}
		
		public function printRecord() : String
		{
			var index:int;
			var records :String = "";
			for(index =0; index < count ; index++ )
			{
				records += printRecordLine(index)+'\n';
			}
			
			return records;
		}
			
		public function printSingleRecord(index :int): String 
		{
			return	printRecordLine(index);
		}
		
		public function printHeaders(): String 
		{
			var headers: String = "";
			headers += "Gene Name" + "	";
			headers += "Sense"+"	";
			headers += "Replichore"+"	";
			headers += "LP"+"	";
			headers += "RP"+"	";
			headers += "Mutation"+"	";
			headers += "Desired Sequence";
			
			return headers;
		}
		
		public function queueRecord(	geneName : String,
											start : int,
											end : int,
											mutation : String,
											replichore : String,
											sense : String,
											sequence : String): void
		{
			// Queue new record information on in the display box.
			this._ngeneName= "mutation_"+(this._count+1);
			this._nsense = sense;
			this._nreplichore = replichore;
			this._nstart = start;
			this._nend = end;
			this._nmutation = mutation;
			this._nsequence = sequence;	
		}

		private function printRecordLine(index :int): String{
			var print :String = "";
			
			// record the remainder of the results
			print += _geneName[index] + "	";
			print += _sense[index] + "	";
			print += _replichore[index] + "	";
			print += _start[index] + "	";
			print += _end[index] + "	";
			print += _mutation[index] + "	";
			print += _sequence[index];
			
			return print;
		}
		
		
	}
	
}