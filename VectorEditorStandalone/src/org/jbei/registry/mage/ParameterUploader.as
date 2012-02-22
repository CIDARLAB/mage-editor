package org.jbei.registry.mage
{
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	
	import org.jbei.registry.view.dialogs.mageDialogs.MageParameterDialogForm;
	import org.jbei.registry.ApplicationFacade;
	public class ParameterUploader
	{
		
		private var fr : FileReference;
		private var uploadData : String;
		
		
		public function ParameterUploader()
		{
			this.fr = new FileReference();
			this.uploadData = "No File Uploaded"; 
		}
		
		// Function for uploading local file from user system, through start UI
		public function upload():void
		{
			this.fr.addEventListener(Event.SELECT, onImportSequenceFileReferenceSelect);
			this.fr.addEventListener(Event.COMPLETE, onImportSequenceFileReferenceComplete);
			this.fr.addEventListener(IOErrorEvent.IO_ERROR, onImportSequenceFileReferenceLoadError);
			this.fr.browse();
		}
		
		// Called to retrieve the uploaded Data as a string
		public function getData() : String
		{
			return this.uploadData;
		}
		
		private function onImportSequenceFileReferenceSelect(event:Event):void
		{
			fr.load();
		}
		
		
		private function showFileImportErrorAlert(message:String):void
		{
			Alert.show("Failed to open file!", message);
		}
		
		private function onImportSequenceFileReferenceComplete(event:Event):void
		{
			
			if( fr.data == null) {
				showFileImportErrorAlert("Empty file!");
				
				return;
			}
			
			this.uploadData = fr.data.toString();
			ApplicationFacade.getInstance().MageProperties.parameterFile = this.uploadData;
		}
		
		private function onImportSequenceFileReferenceLoadError(event:IOErrorEvent):void
		{
			showFileImportErrorAlert(event.text);
		}
		
		
	}
}