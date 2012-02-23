package org.jbei.registry.models
{
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
		private var parameters : String;
		private var targets : String;
		private var _mageResults : String;
		
		// Constructor
		public function MageProperties()
		{
			this.targetFileData 	= "No File Uploaded";	
			this.parameterFileData 	= "No File Uploaded";
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
			return "";
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
		
		
	}
	
}