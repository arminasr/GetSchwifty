//
//  InfoView.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-09.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Get Schwifty!")
                .font(.largeTitle)
                .accentColor(Color(.systemPink))
            Text("This is an open source iOS application providing a list of conferences (mostly iOS and Swift related). \nAnyone who founds a bug 🐛 or is missing a feature is welcome to submit a PR")
                .font(.caption)
            SocialButton(title: "GetSchwifty",
                         type: .github,
                         url: URL(string: "https://github.com/arminasr/GetSchwifty")!)
            Text("Contact me with any suggestions")
            .font(.caption)
            SocialButton(title: "@arminas_r",
                         type: .twitter,
                         url: URL(string: "https://twitter.com/arminas_r")!)
            Text("GetSchwifty is inspired by CocoaConferences project. It contains the data used by GetSchwifty application.")
                .font(.caption)
                .padding(.top)
            SocialButton(title: "CocoaConferences",
                         type: .github,
                         url: URL(string: "https://github.com/Lascorbe/CocoaConferences/")!)
            Spacer()
        }
        .padding()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
