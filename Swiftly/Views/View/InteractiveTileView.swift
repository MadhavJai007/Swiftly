//
//  InteractiveTileView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-10.
//

import SwiftUI

struct InteractiveTileView: View {
    var codeBlock: InteractiveBlock

    var body: some View {
        VStack {
            Text(String(codeBlock.content))
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
        }
        .frame(width: UIScreen.screenWidth/1.25, height: 100, alignment: .leading)
        .background(Color.darkGrayCustom)
        .cornerRadius(20)
        
    }
}


/// Struct which extends DropDelegate that allows drag and drops within grid view to occur
struct DragRelocateDelegate: DropDelegate {
    
    let item: InteractiveBlock
    
    @Binding var listData: [InteractiveBlock]
    @Binding var current: InteractiveBlock?

    /// This function re-orders the original listData array so it matches the
    /// new block order
    func dropEntered(info: DropInfo) {
        
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}


/// Struct that extends DropDelegate that ensures the tile cannot be
/// dragged outside of the grid.
struct DropOutsideDelegate: DropDelegate {
    
    @Binding var current: InteractiveBlock?
        
    func performDrop(info: DropInfo) -> Bool {
        current = nil
        return true
    }
}
