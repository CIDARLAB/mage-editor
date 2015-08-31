package org.jbei.registry.mage
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IChildList;
	import mx.core.UIComponent;
	
	import org.jbei.registry.ApplicationFacade;
	import org.jbei.registry.view.dialogs.mageDialogs.MageTargetDialogForm;
	public class TargetUploader
	{
		
		private var fr : FileReference;
		private var uploadData : String;
		
		
		public function TargetUploader()
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
			ApplicationFacade.getInstance().mageProperties.targetFile = this.uploadData;
			updateTargetPopup();
		}
		
		private function onImportSequenceFileReferenceLoadError(event:IOErrorEvent):void
		{
			showFileImportErrorAlert(event.text);
		}
		
		private function updateTargetPopup():void{
			var children:IChildList = Application.application.systemManager.rawChildren;
			for (var i:int=0; i<children.numChildren;i++){
				var child:DisplayObject = children.getChildAt(i);
				if((child is UIComponent) && UIComponent(child).isPopUp){
					try{
						var box:VBox = (child as UIComponent).getChildAt(0) as VBox;
						var form:MageTargetDialogForm = box.getChildAt(0) as MageTargetDialogForm;
						form.update();
					}catch (err:Error){}
				}
			}
		}
		
	}
}