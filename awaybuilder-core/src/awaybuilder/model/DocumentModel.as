package awaybuilder.model
{
	import awaybuilder.controller.events.DocumentModelEvent;
	import awaybuilder.model.vo.DocumentVO;
	import awaybuilder.model.vo.GlobalOptionsVO;
	import awaybuilder.model.vo.scene.AssetVO;
	import awaybuilder.model.vo.scene.ContainerVO;
	
	import flash.display3D.textures.Texture;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	
	import org.robotlegs.mvcs.Actor;

	public class DocumentModel extends Actor
	{
		private var _documentVO:DocumentVO = new DocumentVO();
		
		private var _empty:Boolean = true;
		public function get empty():Boolean
		{
			return this._empty;
		}
		public function set empty(value:Boolean):void
		{
			this._empty = value;
		}
		
		private var _name:String;
		public function get name():String
		{
			return this._name;
		}
		public function set name(value:String):void
		{
			if(this._name == value)
			{
				return;
			}
			this._name = value;
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.DOCUMENT_NAME_CHANGED));
		}
		
		private var _edited:Boolean = false;
		public function get edited():Boolean
		{
			return this._edited;
		}
		public function set edited(value:Boolean):void
		{
			if(this._edited == value)
			{
				return;
			}
			this._edited = value;
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.DOCUMENT_EDITED));
		}
		
		private var _savedNativePath:String;
		public function get path():String
		{
			return this._savedNativePath;
		}
		public function set path(value:String):void
		{
			this._savedNativePath = value;
		}
		
		private var _selectedAssets:Vector.<AssetVO> = new Vector.<AssetVO>();
		public function get selectedAssets():Vector.<AssetVO>
		{
			return this._selectedAssets;
		}
		public function set selectedAssets(value:Vector.<AssetVO>):void
		{
			this._selectedAssets = value;
		}
		
		private var _globalOptions:GlobalOptionsVO = new GlobalOptionsVO();
		public function get globalOptions():GlobalOptionsVO
		{
			return this._globalOptions;
		}
		
		public function get animations():ArrayCollection
		{
			return _documentVO.animations;
		}
		public function set animations(value:ArrayCollection):void
		{
			_documentVO.animations = value;
		}
		
		public function get geometry():ArrayCollection
		{
			return _documentVO.geometry;
		}
		public function set geometry(value:ArrayCollection):void
		{
			_documentVO.geometry = value;
		}
		
		public function get materials():ArrayCollection
		{
			return _documentVO.materials;
		}
		public function set materials(value:ArrayCollection):void
		{
			_documentVO.materials = value;
		}
		
		public function get scene():ArrayCollection
		{
			return _documentVO.scene;
		}
		public function set scene(value:ArrayCollection):void
		{
			_documentVO.scene = value;
		}
		
//		public function get skeletons():ArrayCollection
//		{
//			return _documentVO.skeletons;
//		}
//		public function set skeletons(value:ArrayCollection):void
//		{
//			_documentVO.skeletons = value;
//		}
		
		public function get textures():ArrayCollection
		{
			return _documentVO.textures;
		}
		public function set textures(value:ArrayCollection):void
		{
			_documentVO.textures = value;
		}
		
		public function get lights():ArrayCollection
		{
			return _documentVO.lights;
		}
		public function set lights(value:ArrayCollection):void
		{
			_documentVO.lights = value;
		}
		
		public function get methods():ArrayCollection
		{
			return _documentVO.methods;
		}
		public function set methods(value:ArrayCollection):void
		{
			_documentVO.methods = value;
		}
		
		
		private var _copiedObjects:Vector.<AssetVO>;
		public function get copiedObjects():Vector.<AssetVO>
		{
			return _copiedObjects;
		}
		public function set copiedObjects(value:Vector.<AssetVO>):void
		{
			_copiedObjects = value;
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.CLIPBOARD_UPDATED));
		}
		
		public function clear():void
		{
			_documentVO = new DocumentVO();
			_globalOptions = new GlobalOptionsVO();
			_selectedAssets = new Vector.<AssetVO>();
			empty = true;
		}
		
		public function removeAssets( source:ArrayCollection, items:ArrayCollection ):void
		{
			for each( var oddItem:AssetVO in items ) 
			{
				removeAsset( source, oddItem );
			}
		}
		public function removeAsset( source:ArrayCollection, oddItem:AssetVO ):void
		{
			for (var i:int = 0; i < source.length; i++) 
			{
				if( source[i].id == oddItem.id )
				{
					source.removeItemAt( i );
					i--;
				}
			}
		}
		
	}
}