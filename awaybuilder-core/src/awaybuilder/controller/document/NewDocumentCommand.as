package awaybuilder.controller.document
{
	import away3d.materials.TextureMaterial;
	import away3d.materials.utils.DefaultMaterialManager;
	import away3d.textures.BitmapTexture;
	
	import awaybuilder.controller.events.DocumentModelEvent;
	import awaybuilder.model.IDocumentModel;
	import awaybuilder.model.ISettingsModel;
	import awaybuilder.model.UndoRedoModel;
	import awaybuilder.model.vo.scene.AssetVO;
	import awaybuilder.model.vo.scene.BitmapTextureVO;
	import awaybuilder.model.vo.scene.MaterialVO;
	import awaybuilder.model.vo.ScenegraphGroupItemVO;
	import awaybuilder.utils.scene.Scene3DManager;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;

	public class NewDocumentCommand extends Command
	{	
		[Inject]
		public var document:IDocumentModel;
		
		[Inject]
		public var undoRedo:UndoRedoModel;

		[Inject]
		public var settings:ISettingsModel;
		
		override public function execute():void
		{
			undoRedo.clear();
			Scene3DManager.clear();
			document.clear();
			
			document.name = "Untitled Library 1";
			document.edited = false;
			document.path = null;

			document.materials.addItem(new MaterialVO( DefaultMaterialManager.getDefaultMaterial() ));
			document.textures.addItem(new BitmapTextureVO( DefaultMaterialManager.getDefaultTexture() ));
			
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.DOCUMENT_UPDATED));
		}
	}
}