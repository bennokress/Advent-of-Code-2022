import XCTest
@testable import AdventOfCode2022

final class Day06Tests: XCTestCase {
    
    let input = """
        Paste example input here ...
        """
    
    func testExample() throws {
        let solver = Solver06()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 0)
        XCTAssertEqual(solver.answer2, 0)
    }
    
}
