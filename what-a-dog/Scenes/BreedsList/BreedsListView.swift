//
//  BreedsListView.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 16/05/22.
//

import SwiftUI

struct BreedsListView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill",
                           "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]

    private var colors: [Color] = [.yellow, .purple, .green]

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach(0 ... 9999, id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
