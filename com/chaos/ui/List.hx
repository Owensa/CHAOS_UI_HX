package com.chaos.ui;

import com.chaos.ui.data.ListObjectData;
import com.chaos.ui.classInterface.IBaseSelectData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IList;
import openfl.display.DisplayObject;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.Bitmap;
import openfl.text.Font;
import openfl.text.TextFormatAlign;
import com.chaos.media.DisplayImage;
import com.chaos.ui.Label;
import com.chaos.ui.ScrollPane;
import com.chaos.data.DataProvider;
import com.chaos.ui.UIDetailLevel;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

	/**
	 * Creates a list box on the fly
	 *
	 * @author Erick Feiling
	 * @date 7-12-2008
	 */
	
	class List extends ScrollPane implements IList implements IBaseUI
	{
    public var textColor(get, set) : Int;
    public var textOverColor(get, set) : Int;
    public var textSelectedColor(get, set) : Int;
    public var textSelectedBackground(get, set) : Int;
    public var allowMultipleSelection(get, set) : Bool;
    public var textAlign(get, set) : String;
    public var dataProvider(get, set) : DataProvider;
	
	/** The type of UI Element */
	public static inline var TYPE : String = "ListBox";
	//private var _thinkness : Float = 1;
	private var _outlineColor : Int = 0x000000;
	private var _outlineAlpha : Float = 1;
	//private var _backgroundColor : Int = 0xFFFFFF;
	//private var _backgroundAlpha : Float = 1;
	private var _list : DataProvider = new DataProvider();
	//private var _outline : Sprite;
	//private var _background : Sprite;
	private var _itemList : Sprite;
	private var _scrollPane : ScrollPane;
	private var _embedFonts : Bool = true;
	private var _font : Font = null;
	private var _selectText : String = "";
	private var _selectIndex : Int = -1;
	private var _textColor : Int = 0x000000;
	private var _textOverColor : Int = 0x000000;
	private var _textSelectedColor : Int = 0xCCCCCC;
	private var _textOverBackground : Int = 0xCCCCCC;
	private var _textSelectedBackground : Int = 0x0000FF;
	//private var _enabled : Bool = true;
	private var _allowMultipleSelection : Bool = false;
	private var _align : String = TextFormatAlign.LEFT;  
	
	/**
	 * Creates a list box on the fly
	 *
	 * @param	listWidth The width of the list
	 * @param	listHeight The height of the list
	 * @param	listData a list of data objects
	 *
	 * @eventType openfl.events.Event.CHANGE
	 */ 
	private function new(listWidth : Int = 100, listHeight : Int = 100, listData : DataProvider = null)
    {
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		//init();
		
		width = listWidth;
		height = listHeight;
		
		if (null != listData)
		_list = listData;
    }
	
	override private function onStageAdd(event : Event) : Void
	{
		UIBitmapManager.watchElement(TYPE, this);
    }
	
	override private function onStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
    }
	
	override function init() : Void
	{
		super.init();
		
		_itemList = new Sprite();
		source = _itemList;
		mode = ScrollPolicy.AUTO;initListStyle();
    }
	
	private function initListStyle() : Void
	{ 
		// UISkin and Style for ScrollPane
		if (null != UIBitmapManager.getUIElement(List.TYPE, UIBitmapManager.LIST_BACKGROUND)) 
		setBackgroundBitmap(UIBitmapManager.getUIElement(List.TYPE, UIBitmapManager.LIST_BACKGROUND));
		
		if ( -1 != UIStyleManager.LIST_BACKGROUND_COLOR)
		backgroundColor = UIStyleManager.LIST_BACKGROUND_COLOR;
		
		if ( -1 != UIStyleManager.LIST_TEXT_NORMAL_COLOR)
		_textColor = UIStyleManager.LIST_TEXT_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.LIST_TEXT_OVER_COLOR)
		_textOverColor = UIStyleManager.LIST_TEXT_OVER_COLOR;
		
		if ( -1 != UIStyleManager.LIST_TEXT_SELECTED_COLOR) 
		_textSelectedColor = UIStyleManager.LIST_TEXT_SELECTED_COLOR;
		
		if ( -1 != UIStyleManager.LIST_TEXT_SELECTED_BACKGROUND_COLOR)
		_textSelectedBackground = UIStyleManager.LIST_TEXT_SELECTED_BACKGROUND_COLOR;
		
		if (null != UIStyleManager.LIST_TEXT_EMBED)
		_font = UIStyleManager.LIST_TEXT_EMBED;
		
		border = UIStyleManager.LIST_BORDER;
    }
	
		/**
		 * @inheritDoc
		 */
		
		override public function reskin() : Void { initListStyle(); draw(); }
		
	
		/**
		 * The default label color
		 */
		
		private function set_textColor(value : Int) : Int 
		{
			_textColor = value;
			draw(); 
			
			return value; 
		}
		 
		/**
		 * Return the color
		 */
		
		private function get_textColor() : Int { return _textColor; }
		 
		/**
		 * Set the roll over state
		 */
		
		private function set_textOverColor(value : Int) : Int 
		{ 
			_textOverColor = value;
			
			return value; 
		}
		 
		/**
		 * Return the color
		 */
		
		private function get_textOverColor() : Int { return _textOverColor; }
		 
		/**
		 * Set the selected of the label
		 */
		
		 private function set_textSelectedColor(value : Int) : Int 
		 { 
			 _textSelectedColor = value;
			 return value;
		 }
		 
	
		/**
		 * Return the color
		 */
		
		private function get_textSelectedColor() : Int { return _textSelectedColor; }
		
	
		/**
		 * The selected text background
		 */
		
		private function set_textSelectedBackground(value : Int) : Int 
		{
			_textSelectedBackground = value;
			
			return value; 
		}
		 
	
		/**
		 * Return the color
		 */
		
		private function get_textSelectedBackground() : Int { return _textSelectedBackground; }
		 
	
		/**
		 * The user can select more then one item on the list
		 */
		
		private function set_allowMultipleSelection(value : Bool) : Bool 
		{
			_allowMultipleSelection = value;
			
			return value; 
		}
		 
		/**
		 * Returns if the user can select more then one at a time.
		 */
		
		private function get_allowMultipleSelection() : Bool { return _allowMultipleSelection; }
		 
		/**
		 * Configure and setup the label to handle embedded fonts
		 *
		 * @param value The font you want to use.
		 *
		 */
		public function setEmbedFont(value : Font) : Void
		{ 
			_font = value; 
			draw(); 
		}
		 
	
		/**
		 * Unload the font that was set by using the setEmbedFont
		 */
		
		public function unloadEmbedFont() : Void { _font = new Font(); draw(); }
		 
	
		/**
		 * Appends an item to the end of the data provider.
		 *
		 * @param item Appends an item to the end of the data provider.
		 *
		 */
		
		public function addItem(item : ListObjectData) : Void { _list.addItem(item); draw(); }
		
		 
		/**
		 * Removes the specified item from the
		 *
		 * @param item  Item to be removed.
		 *
		 */
		
		public function removeItem(item : ListObjectData) : ListObjectData { var oldItem : ListObjectData = _list.removeItem(item); draw(); return oldItem; }  
		
		/**
		 * Removes the item at the specified index
		 *
		 * @param index  The index at which the item is to be added.
		 */
		
		public function removeItemAt(index : Int) : ListObjectData { return _list.removeItemAt(index); }
		
	
		/**
		 * Remove all items out of the list
		 */
		
		public function removeAll() : Void { _list.removeAll(); _selectIndex = -1; draw(); }  
		
		/**
		 * Make sure no items are selected
		 */
		
		public function clear() : Void { clearAllSelected(); }
		 
		/**
		 * Replaces an existing item with a new item
		 *
		 * @param newItem The item to be replaced.
		 * @param oldItem The replacement item.
		 */
		
		public function replaceItem(newItem : ListObjectData, oldItem : ListObjectData) : Void { draw(); return _list.replaceItem(newItem, oldItem); } 
		 
	
		/**
		 * Replaces the item at the specified index
		 *
		 * @param newItem The replacement item.
		 * @param index The replacement item.
		 */
		
		 public function replaceItemAt(newItem : ListObjectData, index : Int) : ListObjectData { draw(); return _list.replaceItemAt(newItem, index); }  
		 
		/**
		 * Returns the item at the specified index.
		 *
		 * @param value Location of the item to be returned.
		 * @return The item at the specified index.
		 *
		 */
		public function getItemAt(value : Int) : ListObjectData { return _list.getItemAt(value); } 
		 
	
		/**
		 * Returns the item at the selected index.
		 *
		 * @return The item at the selected index.
		 *
		 */
		
		 public function getSelected() : ListObjectData { return _list.getItemAt(_selectIndex); } 
		 
	
		/**
		 * A list of selected items
		 * @return An array with selected list items
		 */
		
		public function getSelectedList() : Array<Dynamic>
		{
			var selectedList : Array<Dynamic> = new Array<Dynamic>();
			for (i in 0..._list.length - 1 + 1)
			{
				var listData : com.chaos.ui.classInterface.IBaseSelectData = try cast(_list.getItemAt(i), com.chaos.ui.classInterface.IBaseSelectData) catch (e:Dynamic) null;
				
				if (listData.selected)
				selectedList.push(listData);
			}
			
			return selectedList;
		}
	
		/**
		 * Set if the combo box will be enabled or disable
		 *
		 * @param value Set true if you want to enable the combo box and false if not
		 *
		 */ 
		
		override private function set_enabled(value : Bool) : Bool 
		{
			super.enabled = value; 
			
			return value;
		}
		
	
		/**
		 * Set the align on all the labels
		 */
		
		 private function set_textAlign(value : String) : String
		 {
			 _align = value;
			 return value; 
		 }
		 
	
		/**
		 * Return the setting for the label
		 */
		
		private function get_textAlign() : String 
		{ 
			return _align; 
		}
		
	
		/**
		 * Draw the ListBox and all the UI classes it's using
		 *
		 */
		override public function draw() : Void 
		{
			super.draw();
			
			createList(); 
			
			if (null != _itemList)
			source = _itemList;
		} 
		
	
		/**
		 * Return the index number of the item that was selected
		 */
		
		 public function selectIndex() : Int { return _selectIndex; }
		 
	
		/**
		 * Returns the listed item in the list
		 */
		public function selectText() : String { return _selectText; } 
		 
	
		/**
		 * Replace the current data provider and rebuild the list
		 */
		
		 private function set_dataProvider(value : DataProvider) : DataProvider 
		 {
			 _list = value; 
			 draw();
			 
			 return value; 
		 }  
		 
	
		/**
		 * Returns the data provider being used
		 */
		
		private function get_dataProvider() : DataProvider { return _list; }
		 
	
	private function createList() : Void
	{
		if (null == _list)
		return;
		
		// Remove old one
		removeList();
		
		for (i in 0..._list.length - 1 + 1)
		{
			// Setup text field  
			var listBoxLabel : Label = new Label();
			var listData : com.chaos.ui.classInterface.IBaseSelectData = try cast(_list.getItemAt(i), com.chaos.ui.classInterface.IBaseSelectData) catch (e:Dynamic) null;
			listBoxLabel.text = listData.text; listBoxLabel.textColor = _textColor;
			listBoxLabel.width = width - 1; listBoxLabel.background = false;
			listBoxLabel.name = Std.string(i);
			listBoxLabel.textColor = _textColor;
			listBoxLabel.textField.autoSize = "left";
			listBoxLabel.align = _align;
			listBoxLabel.textFormat.bold = UIStyleManager.LIST_TEXT_BOLD;
			listBoxLabel.textFormat.italic = UIStyleManager.LIST_TEXT_ITALIC;
			
			if ( -1 != UIStyleManager.LIST_TEXT_SIZE) 
			listBoxLabel.size = UIStyleManager.LIST_TEXT_SIZE;
			
			if (null != listData.icon)
			listBoxLabel.setDisplayIcon(listData.icon);
			
			if (null != _font)
			listBoxLabel.setEmbedFont(_font);
			
			// Set location of item  
			if (i > 0) 
			{
				var oldLabel : ILabel = cast(_list.getItemAt(i - 1), IBaseSelectData).label;
				listBoxLabel.y = oldLabel.y + oldLabel.textField.height;
            }
			
			// Keep a ref object for later
			listData.label = listBoxLabel;
			if (listData.selected == true) 
			{ 
				// Set background and text color
				listData.label.textColor = _textSelectedColor;
				listData.label.backgroundColor = _textSelectedBackground;
				listData.label.background = true;
            } 
			
			// Events for text fields
			listBoxLabel.addEventListener(MouseEvent.MOUSE_OVER, textOverEvent, false, 0, true);
			listBoxLabel.addEventListener(MouseEvent.MOUSE_OUT, textOutEvent, false, 0, true);
			listBoxLabel.addEventListener(MouseEvent.MOUSE_DOWN, textSelectedEvent, false, 0, true);
			listBoxLabel.addEventListener(MouseEvent.MOUSE_UP, textUpEvent, false, 0, true);
			_itemList.addChild(listBoxLabel);
        }
		
		refreshPane();
    }
	
	private function removeList() : Void
	{
		if (null == _itemList)
		return ;
		
		// NOTE: Turn this into a class file later
		var i : Int = _itemList.numChildren;
		
		while (i < 0)
		{
			var tempObj : Dynamic = _itemList.removeChildAt(i);
			tempObj.removeEventListener(MouseEvent.MOUSE_OVER, textOverEvent);
			tempObj.removeEventListener(MouseEvent.MOUSE_OUT, textOutEvent);
			tempObj.removeEventListener(MouseEvent.MOUSE_DOWN, textSelectedEvent);
			tempObj.removeEventListener(MouseEvent.MOUSE_UP, textUpEvent);
			tempObj = null;
			
			i--;
        }
		
		_itemList = new Sprite();
		source = _itemList;
    }
	
	private function textOutEvent(event : MouseEvent) : Void
	{  
		
		if (_list.getItemAt(Std.parseInt(event.currentTarget.name)).selected == true) 
		{
			event.currentTarget.textColor = _textSelectedColor;
			event.currentTarget.backgroundColor = _textSelectedBackground;
			event.currentTarget.background = true;
        }
        else
		{
			event.currentTarget.textColor = _textColor;
			event.currentTarget.backgroundColor = _backgroundColor;
			event.currentTarget.background = false;
        }
    }
	
	private function textOverEvent(event : MouseEvent) : Void
	{
		event.currentTarget.backgroundColor = _textOverBackground;
		event.currentTarget.textColor = _textOverColor;
		event.currentTarget.background = true;
    }
	
	private function textSelectedEvent(event : MouseEvent) : Void
	{
		// If user only want one item listed
		if (!_allowMultipleSelection)
		clearAllSelected();
		
		// Set background and text color  
		event.currentTarget.textColor = _textSelectedColor;
		event.currentTarget.backgroundColor = _textSelectedBackground;
		event.currentTarget.background = true;
    }
	
	private function textUpEvent(event : MouseEvent) : Void 
	{  
		// Set text and selected index
		_selectText = event.currentTarget.text;
		_selectIndex = Std.parseInt(event.currentTarget.name);
		_list.getItemAt(_selectIndex).selected = ((_list.getItemAt(_selectIndex).selected)) ? false : true;
		
		event.currentTarget.background = true;dispatchEvent(new Event(Event.CHANGE));
    }
	
	private function clearAllSelected() : Void
	{
		for (i in 0..._list.length - 1 + 1)
		{
			var listData : IBaseSelectData = cast(_list.getItemAt(i), IBaseSelectData);
			listData.selected = false;
			listData.label.textColor = _textColor;listData.label.background = false;
        }
    }
}