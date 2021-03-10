//
//  SheetAbout.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct SheetAbout: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private var specialThanksTo = [ "Friskis&Svettis Sundsvall", "Joshua Ashagre", "Maja Filippa Bergene", "Mohamed Abdi Abdillahi" ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Links
                    HStack {
                        AboutLinkView(title: "App website", link: "https://www.walmin.com/exercisehub")
                        Text("|").font(.body).fontWeight(.bold).fixedSize()
                        AboutLinkView(title: "My website", link: "https://www.walmin.com")
                        Text("|").font(.body).fontWeight(.bold).fixedSize()
                        AboutLinkView(title: "Privacy policy", link: "https://www.walmin.com/exercisehub/privacypolicy.html")
                    }
                    
                    Divider().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    
                    // Special thanks
                    Text("Special thanks to")
                        .font(.title3)
                        .fontWeight(.bold)
                        .fixedSize()
                    
                    ForEach(specialThanksTo) { item in
                        Text("• \(item)")
                            .font(.body)
                            .fixedSize()
                            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        
                    }
                    
                    Divider().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    
                    // Licenses
                    Text("Licenses")
                        .font(.title3)
                        .fontWeight(.bold)
                        .fixedSize()
                    
                    LicenseItemView(title: "Material Design Icons", by: "Google Inc.", license: "Apache License, Version 2.0", link: "https://github.com/google/material-design-icons")
                    LicenseItemView(title: "SDWebImageSwiftUI", by: "DreamPiggy", license: "MIT License", link: "https://github.com/SDWebImage/SDWebImageSwiftUI")
                    
                    Divider().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    
                    Text("Version: 1.0 (1)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .fixedSize()
                    
                }.padding()
                
            }
            .navigationTitle("About")
            .navigationBarItems(trailing:
                // Close
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                
                }
                                
            )
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct SheetAbout_Previews: PreviewProvider {
    static var previews: some View {
        SheetAbout()
        
    }
    
}
