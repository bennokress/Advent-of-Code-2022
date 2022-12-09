import XCTest
@testable import AdventOfCode2022

final class Day09ATests: XCTestCase {
    
    let input = """
        R 4
        U 4
        L 3
        D 1
        R 4
        D 1
        L 5
        R 2
        """
    
    func testExample() throws {
        let solver = Solver09()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 13)
        XCTAssertEqual(solver.answer2, 1)
    }
    
}

final class Day09BTests: XCTestCase {
    
    let input = """
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
        """
    
    func testExample() throws {
        let solver = Solver09()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer2, 36)
    }
    
}
