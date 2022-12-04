import XCTest
@testable import AdventOfCode2022

final class Day04Tests: XCTestCase {
    
    let input = """
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
        """
    
    func testExample() throws {
        let solver = Solver04()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 2)
        XCTAssertEqual(solver.answer2, 4)
    }
    
}
