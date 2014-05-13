package org.jbei.registry.mage
{
	import org.jbei.registry.ApplicationFacade;
	
	public class Oligo
	{
		private var _genbank: String;
		private static var _count : int = 0;
		private var  _name : String;
		private var _id : int;
		private var _bg : Array ;
		private var _bo : Array;
		private var _dg : Array;
		private var _op : int;
		private var _mp : int;
		
		
		public function Oligo(genbankString : String, nameStr: String, id: int)
		{
			// Save the genbank file
			this._genbank =  genbankString;
			this._id = _count;
			this._name = nameStr;
		}
		
		public function get genbank():String
		{
			return _genbank;
		}

		public function get bg() : Array
		{
			return this._bg;
		}
		
		public function get bo() : Array
		{
			return this._bo;
		}
		
		public function get dg() : Array
		{
			return this._dg;
		}
		
		public function get mp() :Number
		{
			return this._mp;
		}
		
		public function get op() : Number
		{
			return this._op;
		}
		
		public function setBg(input : String): void
		{
			this._bg = makeNumberArray( input );
		}
			
		public function setBo(input : String): void
		{
			this._bo = makeNumberArray( input );
		}
		
		public function setDg(input : String): void
		{
			this._dg = makeNumberArray( input );
		}
		
		public function setMp(input : String): void
		{
			this._mp = Number( input );
		}
		
		public function setOp(input : String): void
		{
			this._op = Number(input) ;
		}

		private function makeNumberArray( input :String): Array
		{
			var splits: Array = input.split("\n");
			var returnArray : Array= new Array();
			for ( var ii : int = 0; ii < splits.length ;ii++)
			{
				// Convert to a number
				if ( (splits[ii] as String ).length >1 )
				{
					returnArray[ii] = Number(splits[ii]);
				}
			}
			return  returnArray;
		}
			
		public function select():void
		{
			ApplicationFacade.getInstance().importSequence( this._genbank );
		}
		
		public function get name():String
		{
			return this._name;
		}
		
		public function get id():int
		{
			return this._id;
		}
	}
}