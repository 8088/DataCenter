package com.tudou.ui 
{
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	/**
	 * 右键菜单
	 * 
	 * @author 8088
	 */
	public class RightMenu extends EventDispatcher
	{
		
		public function RightMenu(interactiveObject:InteractiveObject)
		{
			super();
			
			registered = { };
			items = { };
			
			contextMenu = new ContextMenu();
			interactiveObject.contextMenu = contextMenu;
			interactiveObject.contextMenu.hideBuiltInItems();
			if (interactiveObject.stage) interactiveObject.stage.showDefaultContextMenu = false;
		}
		
		private var defaultOptions:Object = 
			{ separatorBefore: false
			, enabled: true
			, visible: true
			};
			
		private function onMenuSelect(evt:ContextMenuEvent):void
		{
			var item:ContextMenuItem = evt.target as ContextMenuItem;
			if (item)
			{
				dispatch(registered[item.caption]);
			}
		}
		
		private function dispatch(code:String):void
		{
			dispatchEvent( new StatusEvent
							( StatusEvent.STATUS
							, false
							, false
							, code
							)
						 );
		}
		
		/**
		 * 设置右键菜单的内置默认项
		 * 
		 * @param	defaultItem:* 内置于上下文菜单中的项
		 */
		public function setBuiltInItems(defaultItem:*):void
		{
			if (defaultItem.forwardAndBack != undefined) contextMenu.builtInItems.forwardAndBack = defaultItem.forwardAndBack;
			if (defaultItem.loop != undefined) contextMenu.builtInItems.loop = defaultItem.loop;
			if (defaultItem.play != undefined) contextMenu.builtInItems.play = defaultItem.play;
			if (defaultItem.print != undefined) contextMenu.builtInItems.print = defaultItem.print;
			if (defaultItem.quality != undefined) contextMenu.builtInItems.quality = defaultItem.quality;
			if (defaultItem.rewind != undefined) contextMenu.builtInItems.rewind = defaultItem.rewind; 
			if (defaultItem.save != undefined) contextMenu.builtInItems.save = defaultItem.save;
			if (defaultItem.zoom != undefined) contextMenu.builtInItems.zoom = defaultItem.zoom;
		}
		
		/**
		 * 添加右键菜单项
		 * 
		 * @param	menu:String 右键菜单字符
		 * @param	evtCode:String 右键菜单对应的事件代码
		 * @param	option:Object 右键菜单对应的设置
		 */
		public function add(menu:String, evtCode:String = null, option:Object = null):void
		{
			if (!registered.hasOwnProperty(menu)) num++;
			
			registered[menu] = evtCode;
			
			if (option == null)
			{
				option = { };
				option.separatorBefore = defaultOptions.separatorBefore;
				if (evtCode == null) option.enabled = false;
				else option.enabled = defaultOptions.enabled;
				option.visible = defaultOptions.visible;
			}
			
			if(!items[menu])
			{
				var item:ContextMenuItem = 
				new ContextMenuItem( menu
									, option.separatorBefore
									, option.enabled
									, option.visible
									);
			   item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMenuSelect);
			   contextMenu.customItems.push(item);
			   items[menu] = item;
			}
			else {
				items[menu].separatorBefore = option.separatorBefore;
				items[menu].enabled = option.enabled;
				items[menu].visible = option.visible;
			}
		}
		
		/**
		 * 删除右键菜单项
		 * 
		 * @param	menu:String 右键菜的字符
		 */
		public function remove(menu:String):void
		{
			if (registered.hasOwnProperty(menu))
			{
				delete registered[menu];
				num--;
				
				var item:ContextMenuItem = items[menu] as ContextMenuItem;
				item.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMenuSelect);
				contextMenu.customItems.splice(contextMenu.customItems.indexOf(item), 1);
			}
		}
		
		protected function processEnabledChange():void
		{
			for (var menu:String in items)
			{
				if (registered[menu] != null) items[menu].enabled = enabled;
			}
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			processEnabledChange();
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		private var contextMenu:ContextMenu;
		private var _enabled:Boolean = true;
		
		private var registered:Object;
		private var items:Object;
		private var num:int;
	}

}