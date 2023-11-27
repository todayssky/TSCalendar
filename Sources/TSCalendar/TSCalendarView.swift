//
//  TSCalendarView.swift
//  
//
//  Created by todayssky on 2023/11/27.
//

import SwiftUI



struct TSCalendarView: View {
    @Binding var date: Date
    
    let minHeight: CGFloat
    var dayViews: [Int: AnyView] = [:]
    
    var body: some View {
        VStack {
            calendarGridView
        }
    }
    
    private var calendarGridView: some View {
        VStack(spacing: 0) {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(spacing: 0),
                    count: 7
                ),
                spacing: 0
            ) {
                ForEach(1 ..< 36, id: \.self) { day in
                    CellView(
                        day: day - date.firstWeekdayOfMonth() + 1,
                        date: date,
                        minHeight: minHeight
                    ) {
                        if let view = dayViews[day - date.firstWeekdayOfMonth() + 1] {
                            view
                        }
                    }
                }
            }
            .border(Color.gray, width: 2)
        }
    }
}

struct CellView<Content: View>: View {
    let day: Int
    let date: Date
    var minHeight: CGFloat
    @ViewBuilder let content: Content
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(day < 1 || day > date.endOfMonth().day ? "": "\(day)")
                    .padding(8)
            }
            content
            .padding(8)
        }
        .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: .infinity, alignment: .topTrailing)
        .border(Color.gray, width: 1)
    }
}

struct TSCalendarView_Previews: PreviewProvider {
    @State static var date = Date()
    static var previews: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(String(date.year))
                    Button(action: {
                        $date.wrappedValue = date.addMonth(month: -1)
                    }) {
                        Text("◀")
                    }
                    Text("\(date.month)月")
                    Button(action: {
                        date = date.addMonth(month: 1)
                    }) {
                        Text("▶")
                    }
                }
                .font(.title)
                TSCalendarView(date: $date, minHeight: 100, dayViews: mock)
                    .padding(20)
            }
        }
    }
}
