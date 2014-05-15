package org.jbei.registry.models
{
	import org.jbei.registry.mage.GenomeUploader;
	import org.jbei.registry.mage.ParameterUploader;
	import org.jbei.registry.mage.TargetUploader;
	
	[Bindable]
	/**
	 * @author Samir Ahmed
	 * */
	public class MageProperties
	{
		/* Data Types in mageProperties */
		
		// Result Data Members
		private var targetFileData : String;
		private var parameterFileData : String;
		private var genomeFileData : String;
		private var genome: String;
		private var parameters : String;
		private var targets : String;
		private var _mageResults : String;
		private var _merlinResults: Array;
		private var oligos : Array;
		private var current : int ;
		private var id : String;
		private var _diversificationTableData : String;
		
		public function get diversificationTableData():String
		{
			return _diversificationTableData;
		}

		public function set diversificationTableData(value:String):void
		{
			_diversificationTableData = value;
		}

		public function set merlinResults( merlinProps : Array) : void
		{
			this._merlinResults = merlinProps;
		}
		
		public function get merlinResults(): Array
		{
			return this._merlinResults;
		}
		
		// Constructor
		public function MageProperties()
		{
			this.targetFileData 	= "No File Uploaded";	
			this.parameterFileData 	= "No File Uploaded";
			this.genome = "No File Uploaded"
			var now:Date = new Date();
			this.id =  Math.round((Math.random()*1000)).toString(10) +"_"+ now.getTime().toString(10) ;
			this.current = 0;
		}
		
		public function set parameterFile( text:String) : void
		{
			this.parameterFileData =  text;
		}
		
		public function set targetFile( text:String) : void
		{
			this.targetFileData = text;
		}

		public function get getSavedGenome() : String
		{
			return this.genome;
		}
		
		public function saveParameterFile( text:String ) : void
		{
			this.parameters = text;
		}
		
		public function saveTargetFile( text:String ) : void
		{
			this.targets =  text;
		}
		
		public function getSavedParameters() : String
		{
			return this.parameters;
		}
		
		public function getSavedTargets (): String
		{
			return this.targets;
		}
		
		public function get parameterFile() : String
		{
			return this.parameterFileData;
		}
		
		public function get targetFile() : String
		{
			return this.targetFileData;
		}
		
		public function set mageResults(response : String): void
		{
			this._mageResults = response; 
		}
		
		public function getGenome(): String
		{
			return this.genomeFileData;
		}
		
		public function setGenome( new_genome : String ): void
		{
			this.genomeFileData = new_genome;
		}
		
		public function saveGenome( new_genome: String) : void
		{
			this.genome = new_genome;
		}
		
		public  function get ID(): String
		{
			return this.id;
		}
		
		// Uploads and stores the parameter file
		public function uploadParameterFile() : void
		{
			// Create an uploader and ask the user about uploading
			var ul : ParameterUploader = new ParameterUploader();
			ul.upload();
			
			// Get the data as a string
			this.parameterFileData = ul.getData();
		}
		
		// Uploads and stores the target file
		public function uploadTargetFile() : void
		{
			// Create an uploader and ask the user about uploading
			var uload : TargetUploader =  new TargetUploader();
			uload.upload();
			
			// Get the data as a string
			this.targetFileData = uload.getData();
		}
		
		// Uploads and stores the start genome file
		public function uploadGenomeFile() : void
		{
			// Create an uploader and ask the user about uploading
			var ul : GenomeUploader = new GenomeUploader();
			ul.upload();
			
			// Get the data as a string
			this.genomeFileData = ul.getData();
		}
	
	}
	
}