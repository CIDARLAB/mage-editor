package org.jbei.registry.mage
{
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	
	import org.jbei.registry.ApplicationFacade;
	import org.jbei.registry.Notifications;
	import org.jbei.registry.view.dialogs.mageDialogs.GenomeDialogForm;

	public class GenomeUploader
	{
		
		private var fr : FileReference;
		private var uploadData : String;
		
		
		public function GenomeUploader()
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
			this.fr.addEventListener(ErrorEvent.ERROR, onImportSequenceFileReferenceLoadError);
			this.fr.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusEvent);
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
			ApplicationFacade.getInstance().mageProperties.setGenome( this.uploadData);
			//TODO: remove if not debugging
			//ApplicationFacade.getInstance().sendNotification(Notifications.UPDATE_STATUS, "Genome Upload Complete")
			//var genomeSizeMsg = "Genome size = " + ApplicationFacade.getInstance().mageProperties.getGenome().length.toString();
			//ApplicationFacade.getInstance().sendNotification(Notifications.UPDATE_STATUS, genomeSizeMsg); 
		}
		
		private function onImportSequenceFileReferenceLoadError(event:IOErrorEvent):void
		{
			showFileImportErrorAlert(event.text);
		}
		
		//TODO: remove when done debugging
		private function onHttpStatusEvent(event:HTTPStatusEvent):void{
			ApplicationFacade.getInstance().sendNotification(Notifications.UPDATE_STATUS, event.toString());
		}
	}
}