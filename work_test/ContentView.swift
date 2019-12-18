//
//  ContentView.swift
//  work_test
//
//  Created by kansei on 2019/11/30.
//  Copyright © 2019 kansei. All rights reserved.
//

import SwiftUI
import Combine

struct block_view: View {
    var re: [block_result]
    let font_size: CGFloat = 8
    @State var aaa: String = ""
    @State var text_storage: [String]
    
    var body: some View {
        HStack( spacing: 0 ){
            ForEach( re ) {
                d in
                if d.write {
                    ZStack{
      
                        MultilineTextField( text: self.$aaa, top: 0, left: 0, bottom: 0, right: 0 )
                        .frame( width: d.width, height: d.height )
                        .border( Color.red )
                        
                        if d.text.count != 0 {
                            ForEach( d.text ){
                                t in
                                Text( t.text )
                                .font( Font.system( size: self.font_size ) )
                                .offset( x: t.of_x, y: t.of_y )
                            }
                        }
                    }
                } else {
                    ZStack{
                    Text( "" )
                    .frame( width: d.width, height: d.height )
                    .border( Color.blue )
                        
                        VStack{
                        ForEach( d.text ){
                            t in
                            Text( /*t.of_x.description*/ t.text )
                                .font( Font.system(size: self.font_size ) )
                            //.offset(x: t.of_x, y: t.of_y )
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MultilineTextField: UIViewRepresentable {
    @Binding var text: String
    @State var top: CGFloat = 0
    @State var left: CGFloat = 0
    @State var bottom: CGFloat = 0
    @State var right: CGFloat = 0
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        //let rabius = view.layer.cornerRadius / 4
        view.textContainerInset = UIEdgeInsets(top: self.top, left: self.left, bottom: self.bottom, right: self.right )
        view.font = UIFont.systemFont(ofSize: 15 )
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, UITextViewDelegate {

        var parent: MultilineTextField

        init(_ textView: MultilineTextField) {
            self.parent = textView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }

}

struct ContentView: View {
    @State var block = data_analyze()
    
    var body: some View {
        VStack( alignment: .leading, spacing: 0 ) {
            ForEach( 0..<self.block.data.count ) {
                i in
                block_view( re: self.block.data[i], text_storage: self.block.storage[i] )
            }
        }
    }
}
   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

