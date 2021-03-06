package com.chaos.ui.layout.classInterface;

import com.chaos.ui.classInterface.IBaseUI;



/**
	 * Interface for both Horizontal and Vertical container
	 *
	 * @author Erick Feiling
	 */

interface IAlignmentContainer extends IBaseContainer
{
    
    
    /**
		 * For making it so the content can overlap or bleed outside the container
		 */
    
    
    
    /**
		 * If true content can overlap the container and false clips it
		 */
    
    var clipping(get, set) : Bool;    
    
    /**
		 * Return the total number of elements being stored
		 */
    
    var length(get, never) : Int;    
    
    /**
		 * Specifies the space between the cell wall and the cell content
		 */
    
    
    
    /**
		 * Return the space in between the cell wall and the content
		 */
    
    var padding(get, set) : Int;    
    
    /**
		 * Set the Horizontal or right to left margin between object
		 */
    
    
    /**
		 * Return the spacing
		 */
    
    var spacingH(get, set) : Int;    
    /**
		 * Set the Vertical or top to bottom spacing between object
		 */
    
    
    /**
		 * Return the spacing
		 */
    
    var spacingV(get, set) : Int;    
    /**
		 * Set the alignment mode
		 *
		 * @see com.chaos.ui.layout.ContainerAlignPolicy
		 */
    
    
    
    /**
		 * Return the alignment mode
		 *
		 * @see com.chaos.ui.layout.ContainerAlignPolicy
		 */
    
    var align(get, set) : String;

    
    /**
		 * Adds more then one item to the object to the list
		 *
		 * @param	list A list of UI Elements
		 */
    
    function addElementList(list : Array<Dynamic>) : Void;
    /**
		 * Return the object inside the container
		 *
		 * @param	value The index of the object inside the container
		 * @return The object that is stored in the container
		 */
    
    function getElementAtIndex(value : Int) : IBaseUI;
    
    /**
		 * Return the object inside the container based on the name passed
		 *
		 * @param	value The name of the object
		 * @return The object that is stored in the container
		 */
    
    function getElementByName(value : String) : IBaseUI;
    
    /**
		 * Add an UI element to the container
		 *
		 * @param	object The object you want to add
		 */
    
    function addElement(object : IBaseUI) : Void;
    
    /**
		 * Remove an UI element from the container
		 *
		 * @param	object The object you want to remove
		 */
    
    function removeElement(object : IBaseUI) : Void;
    
    /**
		 * Remove all items that are stored
		 */
    
    function removeAll() : Void;
}

