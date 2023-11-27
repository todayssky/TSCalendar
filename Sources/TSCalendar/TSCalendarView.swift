//
//  TSCalendarView.swift
//  
//
//  Created by todayssky on 2023/11/27.
//

import SwiftUI

public struct TSCalendarView: View {
    let date: Date
    let minHeight: CGFloat
    var dayViews: [Int: AnyView] = [:]
    var weekStrings: [String] = [
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat"
    ]
    var onTapCell: (Int) -> () =  { day in
        
    }
    
    public init(date: Date, minHeight: CGFloat, dayViews: [Int : AnyView], weekStrings: [String], onTapCell: @escaping (Int) -> Void) {
        self.date = date
        self.minHeight = minHeight
        self.dayViews = dayViews
        self.weekStrings = weekStrings
        self.onTapCell = onTapCell
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            HStack {
                ForEach(weekStrings, id: \.self) { week in
                    Text(week)
                        .frame(maxWidth: .infinity)
                }
            }
            calendarGridView
        }
    }
    
    private var calendarGridView: some View {
        return VStack(spacing: 0) {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(spacing: 0),
                    count: 7
                ),
                spacing: 0
            ) {
                
                ForEach(1 ..< 36, id: \.self) { day in
                    let realDay = day - date.firstWeekdayOfMonth() + 1
                    CellView(
                        day: realDay,
                        date: date,
                        minHeight: minHeight
                    ) {
                        if let view = dayViews[realDay] {
                            view
                        }
                    }
                    .onTapGesture {
                        onTapCell(realDay)
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

        ZStack {
            Color.white
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text(day < 1 || day > date.endOfMonth().day ? "": "\(day)")
                        .foregroundColor(
                            getDayColor(date: Date.from(
                                year: date.year,
                                month: date.month,
                                day: day
                            ))
                        )
                        .padding(8)
                }
                content
                .padding(8)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: .infinity, alignment: .topTrailing)
        .border(Color.gray, width: 1)
    }
    
    func getDayColor(date: Date) -> Color {
        var dayColor: Color = Color.black
        let weekDay = date.weekDay
        if (weekDay == 1) {
            dayColor = Color.red
        } else if (weekDay == 7) {
            dayColor = Color.blue
        }
        
        return dayColor
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
                TSCalendarView(
                    date: date,
                    minHeight: 100,
                    dayViews: mock,
                    weekStrings: [
                        "日曜日",
                        "月曜日",
                        "火曜日",
                        "水曜日",
                        "木曜日",
                        "金曜日",
                        "土曜日",
                    ],
                    onTapCell: { day in
                        print(day)
                    }
                )
                    .padding(20)
            }
        }
    }
}
