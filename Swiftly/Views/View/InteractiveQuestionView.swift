//
//  InteractiveQuestionView.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-13.
//

import SwiftUI

struct InteractiveQuestionView: View {
    
    let chapter = MockData.sampleChapter
    
//    var width: CGFloat

    
    var body: some View {
        

        VStack(alignment: .leading){
            Text("Playground Problem 1")
                .font(.system(size: 35))
                .padding(.leading, 10)
                .padding(.top, 20)
            
            Text("PROBLEM HEADER")
                .font(.system(size: 20, weight: .medium))
                .padding(.leading, 10)
                .padding(.top, 10)
            
            Text("In this problem you're given X amounts of blocks. With these blocks you have to arrange the code in such a way that it will make Y function.")
                .font(.system(size: 20))
                .padding(.leading, 10)
   
            Spacer()
    
        }
        .frame(width: 300, height: 600, alignment: .leading)
        .background(Color.red)
        .cornerRadius(30)
        
    }
}

//struct InteractiveQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        InteractiveQuestionView()
//    }
//}
