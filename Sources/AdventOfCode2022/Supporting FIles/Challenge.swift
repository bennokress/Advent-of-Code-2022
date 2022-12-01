//
// 💡 Challenge
// 🎅🏽 Author: Benno Kress
//

import Foundation

public enum Challenge: Int, CaseIterable, Identifiable {
    
    case day01 = 1
    case day02 = 2
    case day03 = 3
    case day04 = 4
    case day05 = 5
    case day06 = 6
    case day07 = 7
    case day08 = 8
    case day09 = 9
    case day10 = 10
    case day11 = 11
    case day12 = 12
    case day13 = 13
    case day14 = 14
    case day15 = 15
    case day16 = 16
    case day17 = 17
    case day18 = 18
    case day19 = 19
    case day20 = 20
    case day21 = 21
    case day22 = 22
    case day23 = 23
    case day24 = 24
    case day25 = 25
    
    static public var current: Challenge? { 
        guard let currentDay = Date.currentDayInDecember2022 else { return nil }
        return Challenge(rawValue: currentDay)
    }
    
    public var id: Int { rawValue }
    public var date: Date { Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: rawValue))! }
    public var url: URL { URL(string: "https://adventofcode.com/2022/day/\(rawValue)")! }
    
}

extension Date {
    
    static var currentDayInDecember2022: Int? {
        guard Calendar.current.component(.year, from: Date.now) == 2022, Calendar.current.component(.month, from: Date.now) == 12 else { return nil }
        return Calendar.current.component(.day, from: Date.now)
    }
    
}
