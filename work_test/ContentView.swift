//
//  ContentView.swift
//  work_test
//
//  Created by kansei on 2019/11/30.
//  Copyright © 2019 kansei. All rights reserved.
//

import SwiftUI

struct block_data: Identifiable {
    var id:Int
    var width:CGFloat//横
    var height:CGFloat//縦
    var w_num:Int
    var h_num:Int
    var color:Color
    var text:String
}

var word_size =  0

func data_set() -> ( [block_data] ){
    var all_data: [block_data] = []
    let display_size = UIScreen.main.bounds.size
    var w_size = ( display_size.width - 40 ) / 3
    var h_size = ( display_size.height - 40 ) / 10
    
    for i in 0..<3 {
        var c: Color
        if i % 2 == 0 {
            c = Color.yellow
        } else {
            c = Color.green
        }
        
        let bd = block_data( id: i, width: w_size, height: h_size, w_num: i, h_num: 0, color: c, text: "" )
        all_data.append( bd )
    }
    
    w_size = ( display_size.width - 40 ) / 4
    h_size = ( display_size.height - 40 ) / 20
    
    for i in 3..<7 {
        var c: Color
        if i % 2 == 0 {
            c = Color.yellow
        } else {
            c = Color.green
        }
        
        let bd = block_data( id: i, width: w_size, height: h_size, w_num: i, h_num: 0, color: c, text: "" )
        all_data.append( bd )
    }
    
    w_size = ( display_size.width - 40 ) / 2
    h_size = ( display_size.height - 40 ) / 8
    
    for i in 7..<9 {
        var c: Color
        if i % 2 == 0 {
            c = Color.yellow
        } else {
            c = Color.green
        }
        
        let bd = block_data( id: i, width: w_size, height: h_size, w_num: i, h_num: 0, color: c, text: "" )
        
        all_data.append( bd )
    }
    
    word_size = all_data.count
    return ( all_data )
}

struct ContentView: View {
    @State var data = data_set()
    @State var word_list: Array<String> = Array( repeating: "", count: word_size )
    
    var body: some View {
        VStack( alignment: .leading, spacing: 0 ) {
            HStack( spacing: CGFloat( 0 ) ){
                ForEach( data ) {
                    d in
                    if d.id < 3{
                        TextField( "aa", text: self.$word_list[d.id])
                            .frame(width: d.width, height: d.height )
                            .background( d.color )
                            .offset( x: 0, y: -200 )
                    }
                }
            }
            
            HStack( spacing: CGFloat( 0 ) ){
                ForEach( data ) {
                    d in
                    if d.id < 7 && 2 < d.id {
                        TextField( "aa", text: self.$word_list[d.id] )
                        .frame(width: d.width, height: d.height )
                        .background( d.color )
                        .offset( x: 0, y: -200 )
                    }
                }
            }
            
            HStack( spacing: CGFloat( 0 ) ){
                ForEach( data ) {
                    d in
                    if 6 < d.id {
                        TextField( "aa", text: self.$word_list[d.id] )
                        .frame(width: d.width, height: d.height )
                        .background( d.color )
                        .offset( x: 0, y: -200 )
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
