package awaybuilder.controller.scene
{
	import away3d.lights.DirectionalLight;
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;
	
	import awaybuilder.controller.history.HistoryCommandBase;
	import awaybuilder.controller.scene.events.SceneEvent;
	import awaybuilder.model.IDocumentModel;
	import awaybuilder.model.vo.scene.LightVO;
	import awaybuilder.utils.scene.Scene3DManager;

	public class ChangeLightCommand extends HistoryCommandBase
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var document:IDocumentModel;
		
		override public function execute():void
		{
			
			var newAsset:LightVO = event.newValue as LightVO;
			
			var vo:LightVO = document.getLight( newAsset.id ) as LightVO;
			var oldLight:LightBase = vo.linkedObject as LightBase;
			saveOldValue( event, vo.clone() );
			
			vo.name = newAsset.name;
			vo.color = newAsset.color;
			vo.type = newAsset.type;
			trace( "newAsset.radius = " + newAsset.radius );
			vo.radius = newAsset.radius;
			trace( "vo.radius = " + vo.radius );
			vo.fallOff = newAsset.fallOff;
			
			vo.ambientColor = newAsset.ambientColor;
			vo.ambient = newAsset.ambient;
			vo.diffuse = newAsset.diffuse;
			
			vo.directionX = newAsset.directionX;
			vo.directionY = newAsset.directionY;
			vo.directionZ = newAsset.directionZ;
			
			vo.diffuse = newAsset.diffuse;
			vo.specular = newAsset.specular;
			
			
			var linkedObjectChanged:Boolean = false;
			
			if( event.isUndoAction )
			{
				if( vo.linkedObject != newAsset.linkedObject )
				{
					vo.linkedObject = newAsset.linkedObject;
					linkedObjectChanged = true;
				}
			}
			else
			{
				if( (newAsset.type == LightVO.POINT) && (vo.linkedObject is DirectionalLight) )
				{
					vo.linkedObject = new PointLight();
					linkedObjectChanged = true;
				}
				if( (newAsset.type == LightVO.DIRECTIONAL) && (vo.linkedObject is PointLight) )
				{
					vo.linkedObject = new DirectionalLight( newAsset.directionX, newAsset.directionY, newAsset.directionZ );
					linkedObjectChanged = true;
				}
			}
			
			
			vo.apply();
			
			if( linkedObjectChanged ) // update all current
			{
				Scene3DManager.removeLight( oldLight );
				Scene3DManager.addLight( vo.linkedObject as LightBase );
			}
			
			event.items = [vo];
			addToHistory( event );
		}
	}
}