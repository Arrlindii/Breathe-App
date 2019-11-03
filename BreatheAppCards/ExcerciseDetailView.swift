//
//  ExcerciseDetailView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 02.11.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI


struct ExcerciseDetailView: View {
    var body: some View {
        Text("tesitng").background(Color.white)
    }
}

#if DEBUG
struct ExcerciseDetailView_Previews : PreviewProvider {
    static var previews: some View {
        ExcerciseDetailView().onAppear(perform: {
            print("I appeared")
        }).background(Color.black)
    }
}
#endif
