package org.jbei.registry.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Button;
	
	import org.jbei.lib.ui.dialogs.ModalDialog;
	import org.jbei.lib.ui.dialogs.SimpleDialog;
	import org.jbei.registry.ApplicationFacade;
	import org.jbei.registry.MageConstants;
	import org.jbei.registry.Notifications;
	import org.jbei.registry.models.mageProperties;
	import org.jbei.registry.view.dialogs.mageDialogs.MageParameterDialogForm;
	import org.jbei.registry.view.dialogs.mageDialogs.MageResultDialog;
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
			mageBar.mageParameterButton.addEventListener(MouseEvent.CLICK,onMageParameterButtonClick);
			mageBar.mageConnectionButton.addEventListener(MouseEvent.CLICK,onMageConnectionButtonClick);
			mageBar.insertionButton.addEventListener(MouseEvent.CLICK,onInsertionButtonClick);
			mageBar.deletionButton.addEventListener(MouseEvent.CLICK,onDeletionButtonClick);
			mageBar.mismatchButton.addEventListener(MouseEvent.CLICK,onMismatchButtonClick);
			mageBar.mageStatus.addEventListener(MouseEvent.ROLL_OVER,onStatusRollOver);
		}
		
		/* List of Notifications that the MAGE Mediator is interested in*/
		public override function listNotificationInterests():Array 
		{
			return [Notifications.SHOW_MAGE_PARAMETERS_DIALOG
				, Notifications.HIDE_MAGE_PARAMETERS_DIALOG
				, Notifications.SAVE_MAGE_PARAMETERS_DIALOG
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
		
		private function onInsertionButtonClick (event: Event) : void 
		{
			
			// Refresh Selection Values
			refreshInterfaceInformation();
			
			// Start by assuming this is a valid request
			var valid :Boolean = true;
			var reason : String = "";
			
			// Check that we have made not made a selection and just positioned a pointer
			if (_start != -1 && _end != -1)
			{
				valid = false;
				reason = MageConstants.NO_SELECTION_ERROR;
			}
			
			// Check if the Caret Position is negative 1, then we dont do anything
			if (_cp < 0) {
				valid = false;
				reason = MageConstants.INVALID_CARET_POSITION;
			}
			
			// If insertion request is valid, extract the before and after positions
			if (valid)
			{
				var _before : int = _cp;
				var _after : int = _cp+1;
				mageBar.mageStatus.text = MageConstants.INSERTION_VALID;
				clearErrorString();
			}
			else
			{
				mageBar.mageStatus.text = reason;
				setErrorString ( mageBar.insertionButton , reason) ;
			}
		}
		
			
		private function onDeletionButtonClick (event: Event) 
		{
			// Refresh Selection Values
			refreshInterfaceInformation();
			
			// Start by assuming this is a valid request
			var valid :Boolean = true;
			var reason : String = "";
			
			// Check that we have made a selection and not positioned a 
			if (_start == -1 && _end == -1)
			{
				valid = false;
				reason = MageConstants.INVALID_SELECTION_ERROR;
			}
			
			// If deletion request is valid, extract the before and after positions
			if (valid)
			{
				var _before : int = _cp;
				var _after : int = _cp+1;
				mageBar.mageStatus.text = MageConstants.DELETION_VALID;
				clearErrorString();
			}
			else
			{
				mageBar.mageStatus.text = reason;
				setErrorString ( mageBar.insertionButton , reason) ;
			}
			
		}
				
		private function onMismatchButtonClick (event: Event) 
		{
			// Refreshing Selection Values
			refreshInterfaceInformation();
			
			// Start by assuming this is a valid request
			var valid :Boolean = true;
			var reason:String = "";
			
			// Check that we have made a selection and not positioned a 
			if (_start == -1 && _end == -1)
			{
				valid = false;
				reason = MageConstants.INVALID_SELECTION_ERROR;
			}
			
			// If deletion request is valid, extract the before and after positions
			if (valid)
			{
				var _before : int = _cp;
				var _after : int = _cp+1;
				mageBar.mageStatus.text = MageConstants.MISMATCH_VALID;
				clearErrorString();
			}
			else
			{
				mageBar.mageStatus.text = reason;
				setErrorString ( mageBar.insertionButton , reason) ;
			}
		}
		
		
		private function onMageButtonClick(event:Event):void 
		{
			mageBar.mageStatus.text =  "Connecting...";
			//mageBar.mageStatus.text =  MageServerRequest.mageGET("/Mage_Test");
			var mageRequest:URLRequest = new URLRequest("http://localhost:8080/magelet/optMAGE_1");//+servlet);
			var mageLoader:URLLoader = new URLLoader();
			var mageVariables:URLVariables = new URLVariables();
			var Status: String =  "";
			
			mageRequest.method = URLRequestMethod.POST;
			mageRequest.data = collectPostVariables(mageVariables);
			
			/* Function for dealing the completion of the Post Request Response.*/
			function onLoaded(evt: Event) : void { 
				var POSTresponse: String = mageLoader.data;
				mageBar.mageStatus.text = "Request Complete";//if (GETResponse.length <10){GETResponse = "Yes"}
				
				ApplicationFacade.getInstance().MageProperties.MageTextResults = POSTresponse;
				var _mrd:SimpleDialog = new SimpleDialog(MageResultDialog);
				_mrd.title = "Mage Results";
				_mrd.open();
			}
			
			mageLoader.dataFormat = URLLoaderDataFormat.TEXT;
			mageLoader.addEventListener(Event.COMPLETE, onLoaded);
			mageLoader.load(mageRequest);
			try { mageLoader.load(mageRequest); } 
			catch (error:Error) { Status = "Error Connecting";}
			mageBar.mageStatus.text = Status;
			
		}
		
		private function onMageParameterButtonClick(event:Event): void 
		{
			var _mageParameterDialog:ModalDialog = new ModalDialog(MageParameterDialogForm, null);
			_mageParameterDialog.title = "Preferences";
			_mageParameterDialog.open();
				
		}
		
		private function onMageConnectionButtonClick(event: Event): void 
		{

			mageBar.mageStatus.text =  "Connecting...";
			//mageBar.mageStatus.text =  MageServerRequest.mageGET("/Mage_Test");
			var mageRequest:URLRequest = new URLRequest("http://localhost:8080/magelet/optMAGE_1");//+servlet);
			var mageLoader:URLLoader = new URLLoader();
			var mageVariables:URLVariables = new URLVariables();
			var GETResponse : String =  "No Connection";
			
			mageRequest.method = URLRequestMethod.GET;
			mageVariables.test = "Testing";
			mageRequest.data = mageVariables;
			
			function onLoaded(evt: Event) : void { 
				GETResponse = mageLoader.data.substr(0,100);
				mageBar.mageStatus.text = GETResponse;//if (GETResponse.length <10){GETResponse = "Yes"}
			}
			
			mageLoader.dataFormat = URLLoaderDataFormat.TEXT;
			mageLoader.addEventListener(Event.COMPLETE, onLoaded);
			mageLoader.load(mageRequest);
			try { mageLoader.load(mageRequest); } 
			catch (error:Error) { GETResponse = "Error Connecting";}
			mageBar.mageStatus.text = GETResponse;
			
		}
		
		private function collectPostVariables( _mageVariables: URLVariables): URLVariables{
			
			
			//_mageVariables.dnaSequence = ";
			
			var _af : ApplicationFacade = ApplicationFacade.getInstance();
			var _mp :mageProperties= _af.MageProperties;
			var _sequence : String = _af.sequence.sequence;
			var _start : int= _af.selectionStart;
			var _end : int = _af.selectionEnd;
			
			// MetaVariables
			_mageVariables.count = "1";
			
			// Get Target Variables
			_mageVariables.dnaSequence = _sequence;
			_mageVariables.start = _start;
			_mageVariables.end = _end;
			_mageVariables.mutation = "I";
			_mageVariables.mutatedSequence = "x";
			
			// Get the parameter variables
			_mageVariables.oligo_size = _mp.getoligo_size();
			_mageVariables.dG_thresh = _mp.getdg_thresh();
			_mageVariables.mloc_dft = _mp.getmloc_dft();
			_mageVariables.mloc_max = _mp.getmloc_max();
			_mageVariables.addthiol = _mp.getaddthiol();
			
			if ( _mp.getcalc_replic() )
			{_mageVariables.calc_replic = "1";} 
			else 
			{_mageVariables.calc_replic = "0";}
			
			
			return _mageVariables;
		}
		
		private function refreshInterfaceInformation():void {
			
			// Pull the Caret Position from the Application Facade
			this._af = ApplicationFacade.getInstance();
			this._cp  = _af.caretPosition;
			this._start = _af.selectionStart;
			this._end  = _af.selectionEnd;
		}
		
		private function setErrorString( button :mx.controls.Button , error : String ) {
		clearErrorString();
		button.errorString = error;
		
		}
			
		private function clearErrorString() : void 
		{
		// Action Buttons
		mageBar.mageButton.errorString = '';
		mageBar.mageConnectionButton.errorString = '';
		mageBar.mageParameterButton.errorString = '';
		
		// Mutation Buttons
		mageBar.insertionButton.errorString = '';
		mageBar.deletionButton.errorString = '';
		mageBar.mismatchButton.errorString = '';
		
		}
	}
}