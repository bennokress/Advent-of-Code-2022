import XCTest
@testable import AdventOfCode2022

final class Day01Tests: XCTestCase {
    
    let input = """
        1000
        2000
        3000
        
        4000
        
        5000
        6000
        
        7000
        8000
        9000
        
        10000
        """
    
    func testExample() throws {
        let solver = Solver01()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 24_000)
        XCTAssertEqual(solver.answer2, 45_000)
    }
    
}
