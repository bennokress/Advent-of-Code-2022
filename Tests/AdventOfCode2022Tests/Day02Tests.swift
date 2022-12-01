import XCTest
@testable import AdventOfCode2022

final class Day02Tests: XCTestCase {
    
    let input = """
        A Y
        B X
        C Z
        """
    
    func testExample() throws {
        let solver = Solver02()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 15)
        XCTAssertEqual(solver.answer2, 12)
    }
    
}
