package org.jbei.registry.mage
{
	import org.jbei.registry.ApplicationFacade;
	
	public class Oligo
	{
		private var _genbank: String;
		private static var _count : int = 0;
		private var  _name : String;
		private var _id : int;
		
		public function Oligo(genbankString : String, nameStr: String)
		{
			// Save the genbank file
			this._genbank =  genbankString;
			
			this._id = _count++;
			this._name = nameStr;
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