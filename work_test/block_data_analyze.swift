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
    var text: [text_data] = []
    var text_count: Int = 0
}

struct text_data: Identifiable {
    var id: String = ""
    var text: String = ""
    var of_x: CGFloat = 0
    var of_y: CGFloat = 0
}

func data_analyze() -> ( data: Array<Array<block_result>>, storage: Array<Array<String>> ) {
    let img_data: [img_data] = getJSON()
    let display_size: CGSize = UIScreen.main.bounds.size
    let display_max_w: CGFloat = display_size.width * 0.9
    let display_max_h: CGFloat = display_size.height * 0.9
    var result: Array<Array<block_result>> = Array(Array())
    var text_storage: Array<Array<String>> = Array(Array())
    
    var y_count: Int = -1
    var img_max_w: Int = 0
    var img_max_h: Int = 0
    var text_instance: Array<String> = Array()

    for i in 1..<img_data.count {

        if img_data[i].cross.Start_Point.Y == 0 {
            img_max_w += img_data[i].cross.Width
        }
        
        if img_data[i].cross.Start_Point.Y != y_count {
            img_max_h += img_data[i].cross.Height
            y_count = img_data[i].cross.Start_Point.Y
            text_storage.append( text_instance )
            text_instance = Array()
        }
        
        text_instance.append( "" )
        
    }
    
    if text_instance.count != 0 {
        text_storage.append( text_instance )
    }
    
    let w_rate: CGFloat = display_max_w / CGFloat(img_max_w)
    let h_rate: CGFloat = display_max_h / CGFloat(img_max_h)
    y_count = 0
    var instance_storage: Array<block_result> = Array()
    var id: Int = 0
    
    for i in 1..<img_data.count {
        var instance = block_result()
        instance.w_num = img_data[i].cross.Start_Point.X
        instance.h_num = img_data[i].cross.Start_Point.Y
        instance.width = CGFloat( img_data[i].cross.Width ) * w_rate
        instance.height = CGFloat( img_data[i].cross.Height ) * h_rate
        
        if img_data[i].text_area_rate < 0.1 {
            instance.write = true
        }
        
        if img_data[i].text != nil {
            for r in 0..<img_data[i].text!.count {
                var text_instance = text_data()
                text_instance.id = r.description
                text_instance.text = img_data[i].text![r].Text
                text_instance.of_x = CGFloat( img_data[i].text![r].Pos.X ) * w_rate
                text_instance.of_y = CGFloat( img_data[i].text![r].Pos.Y ) * h_rate
                instance.text.append( text_instance )
            }
        }
        
        if i % 2 == 1 {
            instance.color = Color.blue
        }
        
        instance.text_count = instance.text.count
        
        if y_count != img_data[i].cross.Start_Point.Y {
            result.append( instance_storage )
            instance_storage = Array()
            y_count = img_data[i].cross.Start_Point.Y
            id = 0
        }
        
        instance.id = id.description
        instance_storage.append( instance )
        id += 1
    }
    
    if instance_storage.count != 0 {
        result.append( instance_storage )
    }
    
    
    return ( result, text_storage )
}
