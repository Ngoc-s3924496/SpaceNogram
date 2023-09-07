/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Duong Vu Thanh Ngoc
 ID: s3924496 (e.g. 1234567)
 Created  date: 15/08/2023
 Last modified: 6/9/2023
 Acknowledgement: Flaticon.com, Minesweeper Genius
 */

import Foundation

// A function to get the grid size based on the given difficulty string
let difficultySizes: [String: Int] = [
    "Easy": 6,
    "Medium": 8,
    "Hard": 10
]

func generateGameGrid(for difficulty: String) -> (grid: [[Character]], horizontalCounts: [Int], verticalCounts: [Int], startPoint: [Int], endPoint: [Int]) {
    // check the difficulty input
    guard let rowCount = difficultySizes[difficulty] else {
        fatalError("Invalid difficulty level")
    }
    
    let columnCount = rowCount
    // Get the number of bomb based on the difficulty input
    let totalBCount = (difficulty == "Easy" ? 8 : (difficulty == "Medium" ? 12 : 20))
    
    // Fill the arrays with initial value
    var gameGrid = [[Character]](repeating: [Character](repeating: "e", count: columnCount), count: rowCount)
    var horizontalCounts = [Int](repeating: 0, count: rowCount)
    var verticalCounts = [Int](repeating: 0, count: columnCount)
    
    // Generate random start and end points
    var randomStartRow = Int.random(in: 0..<rowCount)
    var randomStartColumn = Int.random(in: 0..<columnCount)
    var randomEndRow = Int.random(in: 0..<rowCount)
    var randomEndColumn = Int.random(in: 0..<columnCount)
    
    // Make sure start and end points are not the same and adjacent
    while true {
        randomStartRow = Int.random(in: 0..<rowCount)
        randomStartColumn = Int.random(in: 0..<columnCount)
        
        randomEndRow = Int.random(in: 0..<rowCount)
        randomEndColumn = Int.random(in: 0..<columnCount)
        
        // Check if start and end points are not adjacent
        if randomStartRow != randomEndRow && abs(randomEndColumn - randomStartColumn) > 1 {
            break // Exit the loop if valid pair found
        }
    }
    
    // Set the two start and end point
    gameGrid[randomStartRow][randomStartColumn] = "o"
    gameGrid[randomEndRow][randomEndColumn] = "x"
    
    // Function to check if there's a valid path between start and end points
    func hasValidPath(_ grid: inout [[Character]], _ startRow: Int, _ startCol: Int, _ endRow: Int, _ endCol: Int) -> Bool {
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)
        return dfsCheck(&grid, &visited, startRow, startCol, endRow, endCol)
    }
    
    // Populate the array with 'b' characters at random positions, while still ensure there is a path for victory
    var bCount = 0
    while bCount < totalBCount {
        let randomRow = Int.random(in: 0..<rowCount)
        let randomColumn = Int.random(in: 0..<columnCount)
        
        // Check if the position is occupied or not
        if gameGrid[randomRow][randomColumn] == "e" &&
            (randomRow != randomStartRow || randomColumn != randomStartColumn) &&
            (randomRow != randomEndRow || randomColumn != randomEndColumn) {
            
            gameGrid[randomRow][randomColumn] = "b"
            
            // Check if a valid path exists after adding the bomb
            if !hasValidPath(&gameGrid, randomStartRow, randomStartColumn, randomEndRow, randomEndColumn) {
                gameGrid[randomRow][randomColumn] = "e" // Relocate the bomb
            } else {
                horizontalCounts[randomRow] += 1
                verticalCounts[randomColumn] += 1
                bCount += 1
            }
        }
    }
    
    return (grid: gameGrid, horizontalCounts: horizontalCounts, verticalCounts: verticalCounts, startPoint: [randomStartRow, randomStartColumn], endPoint: [randomEndRow, randomEndColumn])
}

func dfsCheck(_ grid: inout [[Character]], _ visited: inout [[Bool]], _ row: Int, _ col: Int, _ endRow: Int, _ endCol: Int) -> Bool {
    // Get the number of rows and columns in the grid
    let rowCount = grid.count
    let columnCount = grid[0].count
    
    // Check if the current cell is out of bounds, visited, or contains a 'b' (barrier)
    if row < 0 || row >= rowCount || col < 0 || col >= columnCount || visited[row][col] || grid[row][col] == "b" {
        // If any of these conditions are met, return false
        return false
    }
    
    // Mark the current cell as visited
    visited[row][col] = true
    
    // Check if we have reached the end cell
    if row == endRow && col == endCol {
        // If we have reached the end cell, return true (path found)
        return true
    }
    
    // Explore neighboring cells by recursively calling the function
    if dfsCheck(&grid, &visited, row, col + 1, endRow, endCol) || // Right
        dfsCheck(&grid, &visited, row, col - 1, endRow, endCol) || // Left
        dfsCheck(&grid, &visited, row + 1, col, endRow, endCol) || // Down
        dfsCheck(&grid, &visited, row - 1, col, endRow, endCol) // Up
    {
        // If any of the recursive calls return true, it means a path was found, so return true
        return true
    }
    
    // If none of the neighboring cells lead to the end cell, return false (no path found)
    return false
}


func hasValidPathFromStartToEnd(_ grid: inout [[Character]], startRow: Int, startCol: Int, endRow: Int, endCol: Int) -> Bool {
    let rowCount = grid.count
    let columnCount = grid[0].count
    var visited = Array(repeating: Array(repeating: false, count: columnCount), count: rowCount)
    
    func dfs(row: Int, col: Int) -> Bool {
        if row < 0 || row >= rowCount || col < 0 || col >= columnCount || visited[row][col] || grid[row][col] == "b" {
            return false
        }
        
        let currentChar = grid[row][col]
        
        // If we reach the end point, return true
        if row == endRow && col == endCol {
            return true
        }
        
        // Mark the cell as visited
        visited[row][col] = true
        
        // Recursively check neighboring cells, only check for path created by start point, end point, and chosen tile
        let foundPath = (currentChar == "c" || currentChar == "o" || currentChar == "x") && (
            dfs(row: row + 1, col: col) || // Down
            dfs(row: row - 1, col: col) || // Up
            dfs(row: row, col: col + 1) || // Right
            dfs(row: row, col: col - 1)    // Left
        )
        
        // Mark the cell as unvisited (backtrack)
        visited[row][col] = false
        
        return foundPath
    }
    
    // Start the DFS from the starting point
    return dfs(row: startRow, col: startCol)
}



