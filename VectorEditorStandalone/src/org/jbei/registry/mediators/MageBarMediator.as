package org.jbei.registry.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.events.ListEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	
	import org.jbei.lib.ui.dialogs.ModalDialog;
	import org.jbei.registry.ApplicationFacade;
	import org.jbei.registry.MageConstants;
	import org.jbei.registry.Notifications;
	import org.jbei.registry.mage.Oligo;
	import org.jbei.registry.models.MageProperties;
	import org.jbei.registry.view.dialogs.mageDialogs.MageParameterDialogForm;
	import org.jbei.registry.view.dialogs.mageDialogs.MageTargetDialogForm;
	import org.jbei.registry.view.ui.MageBar;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @author Samir Ahmed
	 */
	public class MageBarMediator extends Mediator
	{
		private var mageBar : MageBar; 
		private var _af:ApplicationFacade;
		private var _start:int;
		private var _end:int;
		private var _cp:int;
		private var NAME: String = "MageBarMediator";
		private var MAGE_DATA:String;
		private var fr : FileReference;
		private var uploadData : String;
		private var _mageLoader :URLLoader ;
		private var _merlinLoader :URLLoader;
		private var _mageClicked :Boolean;
		
		public function MageBarMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			// Assigning view component to mageBar and application facade to applicationFacade
			mageBar = viewComponent as MageBar;
			_af = ApplicationFacade.getInstance();
			
			// Extract information about the user interface
			refreshInterfaceInformation();
			
			// Add event listeners to deal with the mouse click for the following events.
			mageBar.mageButton.addEventListener(MouseEvent.CLICK,onMageButtonClick);
			mageBar.mageUploadParameterButton.addEventListener(MouseEvent.CLICK,onMageParameterButtonClick);
			mageBar.mageConnectionButton.addEventListener(MouseEvent.CLICK,onMageConnectionButtonClick);
			mageBar.mageUploadTargetButton.addEventListener(MouseEvent.CLICK,onMageUploadTargetButtonClick );
			//mageBar.oligoSelect.addEventListener(ListEvent.CHANGE,onOligoSelection);
			
		}
		
		/* List of Notifications that the MAGE Mediator is interested in*/
		public override function listNotificationInterests():Array 
		{
			return [
			];
		}
		
		public override function handleNotification(notification:INotification):void
		{
			switch (notification){
			}
		}
		
		private function onStatusRollOver(event : Event) : void 
		{
			clearErrorString();
		}
		
		private function enableMerlinButton( ) : void
		{
			mageBar.merlinButton.addEventListener(MouseEvent.CLICK,onMerlinButtonClick);
		}
		

		private function onMageParameterButtonClick(event:Event): void 
		{
			var _mageParameterDialog:ModalDialog = new ModalDialog(MageParameterDialogForm, null);
			_mageParameterDialog.title = "Upload Parameter File";
			_mageParameterDialog.open();
				
		}
		
		/* Function for dealing the completion of the Post Request Response.*/
		private function onMageLoaded(evt: Event) : void { 
			var response: String = _mageLoader.data.result;
			if (response == null ) {
				updateStatus(">> Invalid Response Data"); 
				updateStatus(_mageLoader.data.error); 
			}
			else {
				updateStatus(">> New Data");
				var lines:Array = response.split(MageConstants.DELIMITER );
				
				for ( var ii:int =0;  ii < lines.length ; ii++  )
				{
					updateStatus(lines[ii]);
				}
				updateStatus(">> Mage Request Complete");
				updateStatus(">> Enabling Merling Request");
				
				enableMerlinButton();
			}
			
			ApplicationFacade.getInstance().mageProperties.mageResults = response;
		}
		
		/* Function for dealing the completion of the Post Request Response.*/
		private function onMerlinLoaded(evt: Event) : void { 
			var response: String = _merlinLoader.data.genbank;
			var genbanks : Array = new Array();
			if (response == null ) {
				updateStatus(">> Invalid Response Data"); 
				updateStatus(_merlinLoader.data.error);
			}
			else {
				updateStatus(">> Mage Response Recieved");
				var lines:Array = response.split(MageConstants.DELIMITER );
				for ( var ii:int =0;  ii < lines.length ; ii++  )
				{
					genbanks[ii] =  new Oligo(lines[ii]);
					updateStatus(">> Oligo " + genbanks[ii].id + " : " + genbanks[ii].name) ;
				}
				updateStatus(">> Request Complete");
				
			}
			
			// Save the array of oligos to merlin Results data member
			ApplicationFacade.getInstance().mageProperties.merlinResults = genbanks;
			populateOligos();
			
		}
		
		private function onMerlinButtonClick(event:Event):void 
		{
			// Set the Status Connecting
			updateStatus(">> Processing ... Could Take Several Minutes");
			
			// Create a new Post Request and add Variables to it
			var merlinRequest:URLRequest = new URLRequest("http://localhost:8080/magelet/merlin");
			var merlinVariables:URLVariables = new URLVariables();
			merlinRequest.method = URLRequestMethod.POST;
			merlinRequest.data = collectPostVariables(merlinVariables);
			
			var Status: String =  "";
			
			
			// Create a new Loader and set the listener, type and then load.
			_merlinLoader = new URLLoader();
			_merlinLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			_merlinLoader.addEventListener(Event.COMPLETE, onMerlinLoaded);
			try { _merlinLoader.load(merlinRequest); } 
			catch (error:Error) { Status = ">> Error Connecting";}
			updateStatus( Status );
		}
		
		private function onMageButtonClick(event:Event):void 
		{
			// Set the Status Connecting
			updateStatus(">> Processing ... Could Take Several Minutes");
			
			// Create a new Post Request and add Variables to it
			var mageRequest:URLRequest = new URLRequest("http://localhost:8080/magelet/optMAGE_1");//+servlet);
			var mageVariables:URLVariables = new URLVariables();
			mageRequest.method = URLRequestMethod.POST;
			mageRequest.data = collectPostVariables(mageVariables);
			
			var Status: String =  "";
			
			
			// Create a new Loader and set the listener, type and then load.
			_mageLoader = new URLLoader();
			_mageLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			_mageLoader.addEventListener(Event.COMPLETE, onMageLoaded);
			try { _mageLoader.load(mageRequest); } 
			catch (error:Error) { Status = ">> Error Connecting";}
			updateStatus( Status );
		}
		
		private function onMageConnectionButtonClick(event: Event): void 
		{

			updateStatus(">> Connecting...");
			//mageBar.mageStatus.text =  MageServerRequest.mageGET("/Mage_Test");
			var mageRequest:URLRequest = new URLRequest("http://localhost:8080/magelet/optMAGE_1");//+servlet);
			var mageLoader:URLLoader = new URLLoader();
			var mageVariables:URLVariables = new URLVariables();
			var GETResponse : String =  ">> No Connection";
			
			mageRequest.method = URLRequestMethod.GET;
			mageVariables.test = "Testing";
			mageRequest.data = mageVariables;
			
			function onLoaded(evt: Event) : void { 
				GETResponse = mageLoader.data.substr(0,100);
				if (GETResponse == null)
				{
					updateStatus(">> No Connection");
				}
				else {
					updateStatus(GETResponse);
				}
			}
			
			mageLoader.dataFormat = URLLoaderDataFormat.TEXT;
			mageLoader.addEventListener(Event.COMPLETE, onLoaded);
			mageLoader.load(mageRequest);
			try { mageLoader.load(mageRequest); } 
			catch (error:Error) { 
				GETResponse = ">> Error Connecting";
				updateStatus(GETResponse);
			}
			
		}
		
		private function collectPostVariables( _mageVariables: URLVariables): URLVariables{
			
			
			// Get the target File, the Genome Name and the parameter file
			
			var _af : ApplicationFacade = ApplicationFacade.getInstance();
			refreshInterfaceInformation();
			
			var _mp :MageProperties= this._af.mageProperties;
			_mageVariables.targets 		= _mp.getSavedTargets();
			_mageVariables.parameters 	= _mp.getSavedParameters();
			_mageVariables.genome		= _mp.getSavedGenome ;
			
			return _mageVariables;			
			
		}
		
		private function refreshInterfaceInformation():void {
			
			// Pull the Caret Position from the Application Facade
			this._af = ApplicationFacade.getInstance();
			this._cp  = _af.caretPosition;
			this._start = _af.selectionStart;
			this._end  = _af.selectionEnd;
		}
		
		
		private function setErrorString( button :mx.controls.Button , error : String ) : void
		{
			clearErrorString();
			button.errorString = error;
		}
		
		private function onMageUploadTargetButtonClick( event : Event) : void
		{
			var _mageParameterDialog:ModalDialog = new ModalDialog(MageTargetDialogForm, null);
			_mageParameterDialog.title = "Upload Target File";
			_mageParameterDialog.open();			
		}
			
		private function clearErrorString() : void 
		{
		// Action Buttons
		mageBar.mageButton.errorString = '';
		mageBar.mageConnectionButton.errorString = '';
		mageBar.mageUploadParameterButton.errorString = '';
		
		}
		
		private function updateStatus( text :String ): void
		{
			sendNotification(Notifications.UPDATE_STATUS, text );
		}
		
		private function populateOligos (  ) : void {
			
			var oligos : Array = ApplicationFacade.getInstance().mageProperties.merlinResults;
			var oligoInfo: Array = new Array();
			for ( var ii : int =0; ii < oligos.length ; ii++ )
			{
				oligoInfo[ii] =  {"label":(oligos[ii] as Oligo ).name, "data":(oligos[ii] as Oligo).id } ;
				//updateStatus(">>> Made Oligo" +(oligos[ii] as Oligo ).name );
			}
			var oligoCollection :ArrayCollection = new ArrayCollection(oligoInfo);
			
			this.mageBar.oligoSelect.dataProvider = oligoCollection;
			this.mageBar.oligoSelect.labelField = "label";
			this.mageBar.oligoSelect.toolTip = "Select the desired oligo to display";
			updateStatus(">> Displaying First Oligo");
			oligos[0].select();
		}
		
		private function onOligoSelection( ) : void
		{
				// Get and select the correspodning oligo
				(ApplicationFacade.getInstance().mageProperties.merlinResults[mageBar.oligoSelect.selectedIndex] as Oligo ).select();
				
				updateStatus(">>> Displaying Oligo " + mageBar.oligoSelect.selectedIndex );
		}
		
		
	}
}