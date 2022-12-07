import XCTest
@testable import AdventOfCode2022

final class Day07Tests: XCTestCase {
    
    let input = """
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
        """
    
    func testExample() throws {
        let solver = Solver07()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 95437)
        XCTAssertEqual(solver.answer2, 24933642)
    }
    
}
