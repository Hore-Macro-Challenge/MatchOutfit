//
//  DropView.swift
//  MatchImage
//
//  Created by Aiffah Kiysa Waafi on 09/10/23.
//

import SwiftUI

struct Drop: View {
    @ObservedObject var vm : ImageViewModel
    
    var body: some View {
        ZStack {
            ForEach($vm.rows, id: \.self) { $row in
                ZStack() {
                    ForEach($row) { $item in
                        Image(item.value)
                            .resizable()
                            .renderingMode( item.isShowing ?
                                .none : .template
                            )
                            .foregroundColor(.gray)
                            .opacity(item.isShowing ? 1 : 0.5)
                            .frame(width: item.width, height: item.height)
                            .onDrop(of: [.url], isTargeted: .constant(true)) { provider in
                                if let first = provider.first {
                                    let _ = first.loadObject(ofClass: URL.self) { value,error in
                                        guard let url = value else { return }
                                        if item.id  == "\(url)" {
                                            DispatchQueue.main.async {
                                                vm.droppedCount += 1
                                                withAnimation {
                                                    item.isShowing = true
                                                    vm.updateSuffledArray(character: item)
                                                }
                                                
                                                item.isShowing = true
                                            }
                                            
                                        }else {
                                            animationView()
                                        }
                                    }
                                }
                                return false
                            }
                            .offset(x: item.offset_x, y: item.offset_y)
                    }
                }
                if  vm.rows.last != row {
                    Divider()
                }
            }
        }
    }
    
    func animationView() {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)) {
            vm.animateWrong = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)) {
                vm.animateWrong = false
            }
        }
    }
}

struct DropView_Previews: PreviewProvider {
    static var previews: some View {
        Drop(vm: ImageViewModel())
    }
}
