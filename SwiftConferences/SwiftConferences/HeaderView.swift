//
//  HeaderView.swift
//  SwiftConferences
//
//  Created by Arminas Ruzgas on 7/29/19.
//  Copyright © 2019 Arminas Ruzgas. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @Binding var conference: Conference?
    
    var body: some View {
        guard let conference = self.conference else {
            return HeaderImage(image: Image("swift-background"))
        }
        return HeaderImage(image: Image("swift-background"))
    }
}

struct HeaderImage: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .frame(height: 200)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

#if DEBUG
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(conference: .constant(nil))
    }
}
#endif
