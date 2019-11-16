//
//  GithubButton.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-09.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

enum SocialButtonType {
    case github
    case twitter
}

struct SocialButton: View {
    private var title: String
    private var url: URL
    private var appURL: URL? = nil
    private var type: SocialButtonType
    @State private var webViewPresented: Bool = false
    
    init(title: String, type: SocialButtonType, url: URL, appURL: URL? = nil) {
        self.title = title
        self.type = type
        self.url = url
        self.appURL = appURL
    }
    
    private var iconImage: Image {
        switch type {
        case .github:
            return Image("githubIcon")
        case .twitter:
            return Image("twitterIcon")
        }
    }
    
    var body: some View {
        Button(action: {
            guard let appURL = self.appURL else {
                self.webViewPresented.toggle()
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else {
                self.webViewPresented.toggle()
            }
        }) {
            HStack {
                iconImage
                .resizable()
                .frame(width: 22, height: 22)
                Text("\(title)").font(.caption)
            }
        }
        .accentColor(Color(.systemPink))
        .sheet(isPresented: $webViewPresented) {
            ViewsFactory.webView(url: self.url)
        }
    }
}

struct GithubButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialButton(title: "GetSchwifty", type: .github, url: URL(string: "https://github.com/arminasr/GetSchwifty")!)
    }
}
