package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Creates a sound on icon for media players
 *
 * @author Erick Feiling
 */

class SoundOnIcon extends SoundIcon implements IBasicIcon implements IBaseUI
{
    /**
	 * @inheritDoc
	 */
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        super(iconWidth, iconHeight);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        // Move very top with offset to start drawing lines
        iconArea.graphics.moveTo(width - offset, offset / 2);  // 1st line  
        iconArea.graphics.lineTo(width, offset / 2);
        
        iconArea.graphics.moveTo(width - offset, (height / 2) - offset);  // 2nd line  
        iconArea.graphics.lineTo(width, (height / 2) - offset);
        
        iconArea.graphics.moveTo(width - offset, height / 2);  // 3rd line  
        iconArea.graphics.lineTo(width, height / 2);
        
        iconArea.graphics.moveTo(width - offset, (height / 2) - (offset / 2));  // 4th line  
        iconArea.graphics.lineTo(width, (height / 2) - (offset / 2));
        
        iconArea.graphics.moveTo(width - offset, (height / 2) + (offset / 2));  // 5th line  
        iconArea.graphics.lineTo(width, (height / 2) + (offset / 2));
    }
}

