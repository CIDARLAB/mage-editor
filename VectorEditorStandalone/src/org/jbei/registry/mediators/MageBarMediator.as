package org.jbei.registry.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.jbei.lib.ui.dialogs.ModalDialog;
	import org.jbei.lib.ui.dialogs.SimpleDialog;
	import org.jbei.registry.ApplicationFacade;
	import org.jbei.registry.Notifications;
	import org.jbei.registry.models.mageProperties;
	import org.jbei.registry.view.dialogs.mageDialogs.MageResultDialog;
	import org.jbei.registry.view.dialogs.mageDialogs.MageParameterDialogForm;
	import org.jbei.registry.view.ui.MageBar;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @author Samir Ahmed
	 */
	public class MageBarMediator extends Mediator
	{
		private var mageBar : MageBar; 
		private var applicationFacade:ApplicationFacade;
		private var NAME: String = "MageBarMediator";
		private var MAGE_DATA:String;
		public function MageBarMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			// Construct will assign a view component, then assign event listeners
			
			// Assigning view component to mageBar and application facade to applicationFacade
			mageBar = viewComponent as MageBar;
			applicationFacade = ApplicationFacade.getInstance();
			
			mageBar.mageButton.addEventListener(MouseEvent.CLICK,onMageButtonClick);
			mageBar.mageParameterButton.addEventListener(MouseEvent.CLICK,onMageParameterButtonClick);
			mageBar.mageConnectionButton.addEventListener(MouseEvent.CLICK,onMageConnectionButtonClick)
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
		
		
	}
}