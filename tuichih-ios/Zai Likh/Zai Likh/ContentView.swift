//
//  ContentView.swift
//  Zai Likh
//
//  Created by Victor Poon on 2/9/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct ContentView: View {
    @State private var dates = [Date]()
    
    var body: some View {
        NavigationView {
            MasterView(dates: $dates)
                .navigationBarTitle(Text("Master"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
                            withAnimation { self.dates.insert(Date(), at: 0) }
                    }
                    ) {
                        Image(systemName: "plus")
                    }
            )
            DetailView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    @Binding var dates: [Date]
    
    var body: some View {
        List {
            ForEach(dates, id: \.self) { date in
                NavigationLink(
                    destination: DetailView(selectedDate: date)
                ) {
                    Text("\(date, formatter: dateFormatter)")
                }
            }.onDelete { indices in
                indices.forEach { self.dates.remove(at: $0) }
            }
        }
    }
}

struct DetailView: View {
    var selectedDate: Date?
    
    @State private var buttonClicked = 0
    
    var body: some View {
        Group {
            if selectedDate != nil {
                HStack {
                    Text("\(selectedDate!, formatter: dateFormatter)")
                    
                    Picker(selection: $buttonClicked, label:   // $selection
                        Text("Toolbar")
                        , content: {
                            Image(uiImage: UIImage(named: "2_cut")!)
                            Image(uiImage: UIImage(named: "2_copy")!)
                            Image(uiImage: UIImage(named: "2_paste")!)
                            Image(uiImage: UIImage(named: "2_undo")!)
                            Image(uiImage: UIImage(named: "2_redo")!)
                            Image(uiImage: UIImage(named: "2_save")!)
                            Image(uiImage: UIImage(named: "2_star")!)
                            Image(uiImage: UIImage(named: "2_find")!)
                            Image(uiImage: UIImage(named: "2_share")!)
                            Image(uiImage: UIImage(named: "2_skip")!)
                            Image(uiImage: UIImage(named: "2_next")!)
                    })
                    
                    //            Picker(selection: $selectedStrength, label: Text("Strength")) {
                    //                ForEach(0 ..< strengths.count) {
                    //                    Text(self.strengths[$0]) // should be icon instead of text
                    //
                    //                }
                    //            }
                    //                .pickerStyle(.wheel) //.wheel .segmented .radioGroup .popUp
                }
            } else {
                Text("Detail view content goes here")
            }
            
            
        }.navigationBarTitle(Text("Detail"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
