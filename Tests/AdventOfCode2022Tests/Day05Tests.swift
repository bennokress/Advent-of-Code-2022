import XCTest
@testable import AdventOfCode2022

final class Day05Tests: XCTestCase {
    
    let input = """
            [D]    
        [N] [C]    
        [Z] [M] [P]
        1   2   3 
        
        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
        """
    
    func testExample() throws {
        let solver = Solver05()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, "CMZ")
        XCTAssertEqual(solver.answer2, "MCD")
    }
    
}
