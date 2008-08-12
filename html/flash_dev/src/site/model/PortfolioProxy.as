package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.model.vo.ProjectStub_VO;
import delorum.loading.XmlLoader;
import flash.events.*;
import site.SiteFacade;
import site.model.vo.*;
import delorum.errors.ErrorMachine;
import delorum.slides.SlideShow_VO;

/** 
*	This is a singleton class
*/

public class PortfolioProxy extends Proxy implements IProxy
{
	public static const NAME:String = "portfolio_proxy";
	private static var  _instance:PortfolioProxy;
	
	private var _portfolioAr:Array;
	private var _xmlLoaded:Boolean = false;
	private var _portfolioPagesDir:String;
	
	private static var _defaultProject:String;
	private static var _semiActiveStubIndex:int;
	private static var _fullyActiveStubIndex:int;
	
	public function PortfolioProxy( ):void
	{
		super( NAME );
	}
		
	public static function getInstance() : PortfolioProxy 
	{
		_defaultProject 		= null;
		_semiActiveStubIndex 	= -1;
		_fullyActiveStubIndex 	= -1;
		
		if ( _instance == null ) 
			 _instance = new PortfolioProxy( );
		return _instance;
	}
	
	// ______________________________________________________________  Whole Portfolio
	
	public function loadPortfolioXml ( $xmlPath:String ):void
	{
		// If the xml has not yet been loaded...
		if( !_xmlLoaded ) {
			//...load xml
			var ldr:XmlLoader 	= new XmlLoader( $xmlPath );
			ldr.onComplete		= _handlePortfolioXmlLoaded;
			ldr.loadItem();
		// else...
		} else {
			// ...reset state
			_semiActiveStubIndex = -1;
			_sendInitNotification();
		}
	}
	
	private function _handlePortfolioXmlLoaded ( e:Event ):void
	{
		var xml:XML = XML(e.target.data);
		_parsePortfolioXml( xml );
	}
	
	private function _parsePortfolioXml ( $xml:XML ):void
	{
		_portfolioPagesDir = $xml.projects.@portfolioImagesDir;
		_portfolioAr = new Array();
		for each( var node:XML in $xml.projects.projectStub )
		{
			var vo:ProjectStub_VO 	= new ProjectStub_VO();
			vo.xmlPath		   		= $xml.projects.@xmlDir + node.@xml;
			vo.image		   		= $xml.projects.@imageStubDir + node.@image;
			vo.title		   		= node.@title;
			vo.frameX				= node.@frameX;
			vo.shortDescription		= node.shortDescription.elements("*").toXMLString();
			vo.arrayIndex			= _portfolioAr.length;
			vo.bgColor				= ( String( node.@bgColor ).length == 0 )? 0xFFFFFF : uint("0x" + node.@bgColor) ;
			vo.cssList				= ( String( node.@css ).length == 0 )? [ $xml.projects.@defaultCss ]: node.@css.split(",") ;
			
			// create slideshow if it exists
			var slideShowVo			= new SlideShow_VO();
			slideShowVo.parseXml( node.slideShow, $xml.projects.@portfolioImagesDir );
			vo.slideShow			= ( slideShowVo.slides.length != 0 )? slideShowVo : null ;
			_portfolioAr.push( vo );
		}
		
		sendNotification( SiteFacade.LOAD_CSS, String( $xml.projects.@cssFile ) );
		_sendInitNotification();
	}
	
	private function _sendInitNotification (  ):void
	{
		sendNotification( SiteFacade.INIT_PORTFOLIO, _portfolioAr );
		makeStubSemiActiveByName( _defaultProject );
	}
	
	// ______________________________________________________________ Project Stub
	
	public function makeStubSemiActive ( $stubArIndex:uint ):void
	{
		// If stub is not already active, activate it
		if( $stubArIndex != _semiActiveStubIndex ) 
		{
			_fullyActiveStubIndex   = -1;
			_semiActiveStubIndex    = $stubArIndex;
			var stub:ProjectStub_VO = _portfolioAr[ _semiActiveStubIndex ];
			sendNotification( SiteFacade.SHOW_STUB_OVERVIEW, _semiActiveStubIndex );
		}
	}
	
	public function deactivateActiveStub (  ):void
	{
		sendNotification( SiteFacade.DEACTIVATE_PROJECT, _semiActiveStubIndex );
		_semiActiveStubIndex = _fullyActiveStubIndex = -1;
	}
	
	public function makeStubSemiActiveByName ( $name:String ):void
	{
		var len:uint = _portfolioAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var vo:ProjectStub_VO = _portfolioAr[i] as ProjectStub_VO;
			if( _replaceSpaces(vo.title, /\s/g) == $name )
				makeStubSemiActive( vo.arrayIndex );
		}
	}
	
	public function loadProjectXml ( $projectIndex:uint ):void
	{
		// if project is not currently active...
		if( _fullyActiveStubIndex != $projectIndex ){
			_fullyActiveStubIndex = $projectIndex;
			sendNotification( SiteFacade.PROJECT_XML_LOADING );
			var project:ProjectStub_VO = _portfolioAr[ $projectIndex ];
			var ldr:XmlLoader 	= new XmlLoader( project.xmlPath );
			ldr.onComplete		= _parseProjectXml;
			ldr.loadItem();
		}
	}
	
	// Return current project to it's semi active state
	public function hideCaseStudy (  ):void
	{
		if( _fullyActiveStubIndex != -1 ) {
			_fullyActiveStubIndex = -1;
			sendNotification( SiteFacade.HIDE_CASE_STUDY );
		}
	}
	
	private function _parseProjectXml ( e:Event ):void
	{
		
		var xml:XML 		= XML(e.target.data);
		var page:Page_VO	= new Page_VO();
		var rowAr:Array 	= new Array();
		page.setImagesDir(_portfolioPagesDir, xml.page.@imageDir);
		
		for each( var node:XML in xml.page.row )
		{
			var row_vo:Row_VO		= new Row_VO();
			row_vo.columnAr 		= new Array();
			row_vo.title 			= ( String(node.@title).length == 0)? null : node.@title;
			row_vo.bgColor			= ( String(node.@background).length == 0)? 0xFFFFFF : uint("0x" + node.@background) ;
			for each( var col:XML in node.col)
			{
				var col_vo:Col_VO = new Col_VO();
				col_vo.colSpan = uint( col.@span );
				col_vo.content = col;
				row_vo.columnAr.push( col_vo );
			}
			rowAr.push( row_vo );
		}
		page.rowsAr = rowAr;
		sendNotification( SiteFacade.PROJECT_XML_LOADED, page );
	}
	
	// ______________________________________________________________ Private Helpers
	
	private function _replaceSpaces ( $str:String, $searchPattern:RegExp, $replacement:String="_" ):String
	{
	 	return $str.replace( $searchPattern, $replacement)
	}
	
	// ______________________________________________________________ Getters / Setters
	
	public function get semiActiveStubIndex (  ):uint   { return _semiActiveStubIndex; };
	public function get currentProjectUrl   (  ):String { 
		var stub:ProjectStub_VO = _portfolioAr[_semiActiveStubIndex] as ProjectStub_VO;
		return _replaceSpaces( stub.title, /\s/g );  
	}
	
	public function set defaultProject ( $str:String ):void	{ _defaultProject = $str; };
	

}
}