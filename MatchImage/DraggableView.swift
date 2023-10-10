//
//  DraggableView.swift
//  MatchImage
//
//  Created by Aiffah Kiysa Waafi on 09/10/23.
//

import SwiftUI

struct DraggableView: View {
    var body: some View {
        Image(systemName: "figure.golf")
            .frame(minWidth: 50, minHeight: 50)
            .background(.red)
            .foregroundStyle(.white)
            .draggable(Image(systemName: "figure.golf")) {
                Label("Figure playing golf", systemImage: "figure.golf")
            }
    }
}

struct DraggableView_Previews: PreviewProvider {
    static var previews: some View {
        DraggableView()
    }
}
