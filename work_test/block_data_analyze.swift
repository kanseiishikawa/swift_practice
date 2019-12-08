//
//  block_data_analyze.swift
//  work_test
//
//  Created by 石川 幹晴 on 2019/12/07.
//  Copyright © 2019 kansei. All rights reserved.
//

import Foundation
import SwiftUI

struct block_result: Identifiable {
    var id: String = ""
    var w_num: Int = 0
    var h_num: Int = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var write: Bool = false
    var color: Color = Color.yellow
}

func data_analyze() -> ( data: [block_result], max_num: Int ) {
    let img_data = getJSON()
    let display_size = UIScreen.main.bounds.size
    let display_max_w = display_size.width * 0.9
    let display_max_h = display_size.height * 0.9
    var result: Array<block_result> = Array()
    
    var y_count = -1
    var img_max_w = 0
    var img_max_h = 0
    
    for i in 1..<img_data.count {
        if img_data[i].cross.Start_Point.X == 0 {
            img_max_w += img_data[i].cross.Width
        }
        
        if img_data[i].cross.Start_Point.Y != y_count {
            img_max_h += img_data[i].cross.Height
            y_count = img_data[i].cross.Start_Point.Y
        }
    }
    
    let w_rate = display_max_w / CGFloat( img_max_w )
    let h_rate = display_max_h / CGFloat( img_max_h )
    
    for i in 1..<img_data.count {
        var instance = block_result()
        instance.id = ( i - 1 ).description
        instance.w_num = img_data[i].cross.Start_Point.X
        instance.h_num = img_data[i].cross.Start_Point.Y
        instance.width = CGFloat( img_data[i].cross.Width ) * w_rate
        instance.height = CGFloat( img_data[i].cross.Height ) * h_rate
        
        if img_data[i].text_area_rate < 0.3 {
            instance.write = true
        }
        
        if i % 2 == 1 {
            instance.color = Color.blue
        }
        
        result.append( instance )
    }
    
    
    return ( result, y_count )
}
