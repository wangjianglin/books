//
//  PdfContentTile.swift
//  reader
//
//  Created by lin on 14-9-5.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class PdfContentTile:CATiledLayer{
    
    override class func fadeDuration()->CFTimeInterval{
        return 0.0;
    }


    override init()
    {
        super.init();
        self.tmp();
    }
    func tmp(){
        self.levelsOfDetail = 16; // Zoom levels
            
        self.levelsOfDetailBias = (16 - 1); // Bias
        
        let mainScreen = UIScreen.mainScreen();
        let screenScale = mainScreen.scale;
        
        let screenBounds = mainScreen.bounds;
        let w_pixels = screenBounds.size.width * screenScale;
        let h_pixels = screenBounds.size.height * screenScale;
        let max = ((w_pixels < h_pixels) ? h_pixels : w_pixels);
        let sizeOfTiles:CGFloat = ((max < 512.0) ? 512.0 : 1024.0);
            self.tileSize = CGSizeMake(sizeOfTiles, sizeOfTiles);
    }
    
    override init(layer: AnyObject){
        super.init(layer:layer);
        self.tmp();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
