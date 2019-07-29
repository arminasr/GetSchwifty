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
                        CategoryItem(conference: conference)
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
                .renderingMode(.original)
                .clipShape(Circle())
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
        CategoryRow(title: "Upcoming conferences", items: [Conference(), Conference(), Conference()])
    }
}
#endif
