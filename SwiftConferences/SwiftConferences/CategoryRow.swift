//
//  CategoryRow.swift
//  SwiftConferences
//
//  Created by Arminas Ruzgas on 7/29/19.
//  Copyright © 2019 Arminas Ruzgas. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    var title: String
    @Binding var selectedItem: Conference?
    var items: [Conference]
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(title)
                .font(.title)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items, id: \.name) { conference in
                        Button( action: {
                            guard self.selectedItem == nil else {
                                self.selectedItem = nil
                                return
                            }
                            self.selectedItem = conference
                        }) {
                            CategoryItem(conference: conference)
                                                        .padding()
                        }
                        .accentColor(.black)
                        
                    }
                }
            }
            .frame(height: 200)
        }
    }
}

struct CategoryItem: View {
    var conference: Conference
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "photo")
                .resizable()
                .frame(height: 120)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)
            Text(conference.name)
                .font(.headline)
            
            Text(String(conference.startingDate?.description ?? ""))
                .font(.caption)
        }
    }
}

#if DEBUG
struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(title: "Upcoming conferences", selectedItem: .constant(nil), items: [Conference(), Conference(), Conference()])
    }
}
#endif
