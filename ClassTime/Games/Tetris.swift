//
//  Tetris.swift
//  ClassTime
//
//  Created by August Wetterau on 1/27/22.
//

import Foundation
import SwiftUI
import Combine

struct TetrisGameView: View {
    @ObservedObject var tetrisGame = TetrisGameViewModel()
    
    var body: some View {
        ZStack() {
        GeometryReader { (geometry: GeometryProxy) in
            self.drawBoard(boundingRect: geometry.size)
        }
        .gesture(tetrisGame.getMoveGesture())
        .gesture(tetrisGame.getRotateGesture())
            VStack() {
                HStack() {
                    Spacer()
                    Text(String(tetrisGame.tetrisGameModel.score)).font(.largeTitle).bold().padding(.top)
                    Spacer()
                }
                Spacer()
            }
    }
    }
    
    func drawBoard(boundingRect: CGSize) -> some View {
        let columns = self.tetrisGame.numColumns
        let rows = self.tetrisGame.numRows
        let blocksize = min(boundingRect.width/CGFloat(columns), boundingRect.height/CGFloat(rows))
        let xoffset = (boundingRect.width - blocksize*CGFloat(columns))/2
        let yoffset = (boundingRect.height - blocksize*CGFloat(rows))/2
        let gameBoard = self.tetrisGame.gameBoard
        
        return ForEach(0...columns-1, id:\.self) { (column:Int) in
            ForEach(0...rows-1, id:\.self) { (row:Int) in
                Path { path in
                    let x = xoffset + blocksize * CGFloat(column)
                    let y = boundingRect.height - yoffset - blocksize*CGFloat(row+1)
                    
                    let rect = CGRect(x: x, y: y, width: blocksize, height: blocksize)
                    path.addRect(rect)
                }
                .fill(gameBoard[column][row].color)
            }
        }
    }
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}

class TetrisGameModel: ObservableObject {
    var numberRows: Int
    var numberColumns: Int
    @Published var gameBoard: [[TetrisGameBlock?]]
    @Published var tetromino: Tetromino?
    @Published var score = 0
    var timer: Timer?
    var speed: Double
    
    var shadow: Tetromino? {
        guard var lastShadow = tetromino else {return nil}
        var testShadow = lastShadow
        while(isValidTetromino(testTetromino: testShadow)){
            lastShadow = testShadow
            testShadow = lastShadow.moveBy(row: -1, column: 0)
        }
        return lastShadow
    }
    
    init(numRows: Int = 23, numColumns: Int = 10) {
        self.numberRows = numRows
        self.numberColumns = numColumns
        
        gameBoard = Array(repeating: Array(repeating: nil, count: numRows), count: numColumns)
        speed = 0.5
        resumeGame()
    }
    
    func resumeGame(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
    }
    
    func pauseGame(){
        timer?.invalidate()
        
    }
    
    func runEngine(timer: Timer){
        if clearLines(){
            print("Linne Cleared")
            score += 1
            return
        }
        guard tetromino != nil else {
            print("Spawning new Tetromino")
            tetromino = Tetromino.createNewTetromino(numRows: numberRows, numColumns: numberColumns)
            if !isValidTetromino(testTetromino: tetromino!) {
                print("Game over!")
                pauseGame()
            }
            return
        }
        if moveTetrominoDown() {
            print("Moving Tetromino down")
            return
        }
        print("Placing tetromino")
        placeTetromino()
    }
    func dropTetromino(){
        while (moveTetrominoDown()){}
    }
    func moveTetrominoRigth()-> Bool{
        return moveTetromino(rowOffset: 0, columnOffset: 1)
    }
    func moveTetrominoLeft()-> Bool {
        return moveTetromino(rowOffset: 0, columnOffset: -1)
    }
    
    func moveTetrominoDown()-> Bool{
        return moveTetromino(rowOffset: -1, columnOffset: 0)
    }
    
    func moveTetromino(rowOffset: Int, columnOffset: Int) -> Bool {
        guard let currentTetromino = tetromino else {return false}
        
        let newTetromino = currentTetromino.moveBy(row: rowOffset, column: columnOffset)
        if isValidTetromino (testTetromino: newTetromino){
            tetromino = newTetromino
            return true
        }
        return false
    }
    
    func rotateTetromino(clockwise: Bool){
        guard let currentTetromino = tetromino else {return}
        
        let newTetrominoBase = currentTetromino.rotate(clockwise: clockwise)
        let kicks = currentTetromino.getKicks(clockwise: clockwise)
        
        for kick in kicks {
            let newTetromino = newTetrominoBase.moveBy(row: kick.row, column: kick.column)
            if isValidTetromino(testTetromino: newTetromino){
                tetromino = newTetromino
                return
            }
        }
    }
    
    func isValidTetromino(testTetromino: Tetromino) -> Bool {
        for block in testTetromino.blocks {
            let row = testTetromino.origin.row + block.row
            if row < 0 || row >= numberRows { return false }
            
            let column = testTetromino.origin.column + block.column
            if column < 0 || column >= numberColumns { return false }
            
            if gameBoard[column][row] != nil { return false }
        }
        return true
    }
    func placeTetromino() {
        guard let currentTetromino = tetromino else {
            return
        }
        
        for block in currentTetromino.blocks {
            let row = currentTetromino.origin.row + block.row
            if row < 0 || row >= numberRows { continue }
            
            let column = currentTetromino.origin.column + block.column
            if column < 0 || column >= numberColumns { continue }
            
            gameBoard[column][row] = TetrisGameBlock(blockType: currentTetromino.blockType)
        }
        
        tetromino = nil
    }
    func clearLines() -> Bool {
        var newBoard: [[TetrisGameBlock?]] = Array(repeating: Array(repeating: nil, count: numberRows), count: numberColumns)
        var boardUpdated = false
        var nextRowToCopy = 0
        
        for row in 0...numberRows-1 {
            var clearLine = true
            for column in 0...numberColumns-1 {
                clearLine = clearLine && gameBoard[column][row] != nil
            }
            
            if !clearLine {
                for column in 0...numberColumns-1 {
                    newBoard[column][nextRowToCopy] = gameBoard[column][row]
                }
                nextRowToCopy += 1
            }
            boardUpdated = boardUpdated || clearLine
        }
        
        if boardUpdated {
            gameBoard = newBoard
        }
        return boardUpdated
    }
    
}


struct TetrisGameBlock {
    var blockType: BlockType
}

enum BlockType: CaseIterable {
    case i, t, o, j, l, s, z
}

struct Tetromino {
    var origin: BlockLocation
    var blockType: BlockType
    var rotation: Int
    
    var blocks: [BlockLocation] {
        return Tetromino.getBlocks(blockType: blockType, rotation: rotation)
    }
    
    func moveBy(row: Int, column: Int)-> Tetromino {
        let newOrigin = BlockLocation(row: origin.row + row, column: origin.column + column)
        return Tetromino(origin: newOrigin, blockType: blockType, rotation: rotation)
    }
    
    func rotate(clockwise: Bool) -> Tetromino{
        return Tetromino(origin: origin, blockType: blockType, rotation: rotation + (clockwise ? 1 : -1))
    }
    
    func getKicks(clockwise: Bool) -> [BlockLocation] {
        return Tetromino.getKicks(blockType: blockType, rotation: rotation, clockwise: clockwise)
    }
    
    static func getBlocks(blockType: BlockType, rotation: Int = 0) -> [BlockLocation] {
        let allBlocks = getAllBlocks(blockType: blockType)
        
        var index = rotation % allBlocks.count
        if (index < 0) { index += allBlocks.count}
        
        return allBlocks[index]
    }
    
    static func getAllBlocks(blockType: BlockType) ->[[BlockLocation]]{
        switch blockType {
        case .i:
            return [[BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 0, column: 2)],
                    [BlockLocation(row: -1, column: 1), BlockLocation(row: 0, column: 1), BlockLocation(row: 1, column: 1), BlockLocation(row: -2, column: 1)],
                    [BlockLocation(row: -1, column: -1), BlockLocation(row: -1, column: 0), BlockLocation(row: -1, column: 1), BlockLocation(row: -1, column: 2)],
                    [BlockLocation(row: -1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: 1, column: 0), BlockLocation(row: -2, column: 0)]]
        case .o:
            return [[BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 1, column: 1), BlockLocation(row: 1, column: 0)]]
        case .t:
            return [[BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 1, column: 0)],
                    [BlockLocation(row: -1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 1, column: 0)],
                    [BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: -1, column: 0)],
                    [BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 1, column: 0), BlockLocation(row: -1, column: 0)]]
        case .j:
            return [[BlockLocation(row: 1, column: -1), BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1)],
                    [BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0), BlockLocation(row: 1, column: 1)],
                    [BlockLocation(row: -1, column: 1), BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1)],
                    [BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0), BlockLocation(row: -1, column: -1)]]
        case .l:
            return [[BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 1, column: 1)],
                    [BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0), BlockLocation(row: -1, column: 1)],
                    [BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: -1, column: -1)],
                    [BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0), BlockLocation(row: 1, column: -1)]]
        case .s:
            return [[BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: 1, column: 0), BlockLocation(row: 1, column: 1)],
                    [BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: -1, column: 1)],
                    [BlockLocation(row: 0, column: 1), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0), BlockLocation(row: -1, column: -1)],
                    [BlockLocation(row: 1, column: -1), BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0)]]
        case .z:
            return [[BlockLocation(row: 1, column: -1), BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1)],
                    [BlockLocation(row: 1, column: 1), BlockLocation(row: 0, column: 1), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0)],
                    [BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 0), BlockLocation(row: -1, column: 0), BlockLocation(row: -1, column: 1)],
                    [BlockLocation(row: 1, column: 0), BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: -1), BlockLocation(row: -1, column: -1)]]
            
        }
    }
    
    static func createNewTetromino(numRows: Int, numColumns: Int) -> Tetromino {
        let blockType = BlockType.allCases.randomElement()!
        
        var maxRow = 0
        for block in getBlocks(blockType: blockType) {
            maxRow = max(maxRow, block.row)
        }
        
        let origin = BlockLocation(row: numRows - 1 - maxRow, column: (numColumns-1)/2)
        return Tetromino(origin: origin, blockType: blockType, rotation: 0)
    }
    
    static func getKicks(blockType: BlockType, rotation: Int, clockwise: Bool) -> [BlockLocation]{
        let rotationCount = getAllKicks(blockType: blockType).count
        
        var index = rotation % rotationCount
        if index < 0 {index += rotationCount}
        
        var kicks = getAllKicks(blockType: blockType)[index]
        if !clockwise {
            var counterKicks: [BlockLocation] = []
            for kick in kicks {
                counterKicks.append(BlockLocation(row: -1 * kick.row, column: -1 * kick.column))
            }
            kicks = counterKicks
        }
        return kicks
    }
    
    static func getAllKicks(blockType: BlockType) -> [[BlockLocation]] {
        switch blockType {
        case .o:
            return [[BlockLocation(row: 0, column: 0)]]
        case .i:
            return [[BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: -2), BlockLocation(row: 0, column: 1), BlockLocation(row: -1, column: -2), BlockLocation(row: 2, column: -1)],
                    [BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: -1), BlockLocation(row: 0, column: 2), BlockLocation(row: 2, column: -1), BlockLocation(row: -1, column: 2)],
                    [BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 2), BlockLocation(row: 0, column: -1), BlockLocation(row: 1, column: 2), BlockLocation(row: -2, column: -1)],
                    [BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 0, column: -2), BlockLocation(row: -2, column: 1), BlockLocation(row: 1, column: -2)]
            ]
        case .j, .l, .s, .z, .t:
            return [[BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: -1), BlockLocation(row: 1, column: -1), BlockLocation(row: 0, column: -2), BlockLocation(row: -2, column: -1)],
                    [BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: -1, column: 1), BlockLocation(row: 2, column: 0), BlockLocation(row: 1, column: 2)],
                    [BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: 1), BlockLocation(row: 1, column: 1), BlockLocation(row: -2, column: 0), BlockLocation(row: -2, column: 1)],
                    [BlockLocation(row: 0, column: 0), BlockLocation(row: 0, column: -1), BlockLocation(row: -1, column: -1), BlockLocation(row: 2, column: 0), BlockLocation(row: 2, column: -1)]
            ]
        }
    }
}
struct BlockLocation {
    var row: Int
    var column: Int
}
extension Color{
    public static var tetrisBlack = Color(red: 59/255, green: 68/255, blue: 75/255)
    public static var tetrisRed = Color(red: 255/255, green: 50/255, blue: 50/255)
    public static let tetrisLightBlue = Color(red: 173/255, green: 221/255, blue: 230/255)
    public static let tetrisDarkBlue = Color(red: 0/255, green: 0/255, blue: 139/255)
    public static let tetrisGreen = Color(red: 50/255, green: 205/255, blue: 50/255)
    public static let tetrisYellow = Color(red: 241/255, green: 255/255, blue: 38/255)
    public static let tetrisOrange = Color(red: 253/255, green: 143/255, blue: 0/255)
    public static let tetrisPurple = Color(red: 247/255, green: 22/255, blue: 240/255)
    
    public static var tetrisRedShadow = Color(red: 255/255, green: 160/255, blue: 122/255)
    public static let tetrisLightBlueShadow = Color(red: 224/255, green: 255/255, blue: 255/255)
    public static let tetrisDarkBlueShadow = Color(red: 176/255, green: 224/255, blue: 230/255)
    public static let tetrisGreenShadow = Color(red: 144/255, green: 238/255, blue: 144/255)
    public static let tetrisYellowShadow = Color(red: 255/255, green: 255/255, blue: 153/255)
    public static let tetrisOrangeShadow = Color(red: 247/255, green: 197/255, blue: 121/255)
    public static let tetrisPurpleShadow = Color(red: 230/255, green: 230/255, blue: 250/255)
}


class TetrisGameViewModel: ObservableObject {
    @Published var tetrisGameModel = TetrisGameModel()
    
    var numRows: Int { tetrisGameModel.numberRows }
    var numColumns: Int { tetrisGameModel.numberColumns }
    var gameBoard: [[TetrisGameSquare]] {
        var board = tetrisGameModel.gameBoard.map { $0.map(convertToSquare) }
        
        if let shadow = tetrisGameModel.shadow{
            for blockLocation in shadow.blocks{
                board[blockLocation.column + shadow.origin.column][blockLocation.row + shadow.origin.row] = TetrisGameSquare(color: getColorShadow(blockType: shadow.blockType))
            }
        }
        
        if let tetromino = tetrisGameModel.tetromino {
            for blockLocation in tetromino.blocks {
                board[blockLocation.column + tetromino.origin.column][blockLocation.row + tetromino.origin.row] = TetrisGameSquare(color: getColor(blockType: tetromino.blockType))
            }
        }
        
        return board
    }
    
    var anyCancellable: AnyCancellable?
    var lastMoveLocation: CGPoint?
    var lastRotateAngle: Angle?
    
    init() {
        anyCancellable = tetrisGameModel.objectWillChange.sink {
            self.objectWillChange.send()
        }
    }
    
    func convertToSquare(block: TetrisGameBlock?) -> TetrisGameSquare {
        return TetrisGameSquare(color: getColor(blockType: block?.blockType))
    }
    
    func getColor(blockType: BlockType?) -> Color {
        switch blockType {
        case .i:
            return .tetrisLightBlue
        case .j:
            return .tetrisDarkBlue
        case .l:
            return .tetrisOrange
        case .o:
            return .tetrisYellow
        case .s:
            return .tetrisGreen
        case .t:
            return .tetrisPurple
        case .z:
            return .tetrisRed
        case .none:
            return .tetrisBlack
        }
    }
    func getColorShadow(blockType: BlockType) -> Color{
        switch blockType {
        case .i:
            return .tetrisLightBlueShadow
        case .j:
            return .tetrisDarkBlueShadow
        case .l:
            return .tetrisOrangeShadow
        case .o:
            return .tetrisYellowShadow
        case .s:
            return .tetrisGreenShadow
        case .t:
            return .tetrisPurpleShadow
        case .z:
            return .tetrisRedShadow
        }
    }
    func getRotateGesture() -> some Gesture {
        let tap = TapGesture()
            .onEnded({self.tetrisGameModel.rotateTetromino(clockwise: true)})
        
        let rotate = RotationGesture()
            .onChanged(onRotateChanged(value:))
            .onEnded(onRotateEnd(value:))
        
        return tap.simultaneously(with: rotate)
    }
    
    func onRotateChanged(value: RotationGesture.Value) {
        guard let start = lastRotateAngle else {
            lastRotateAngle = value
            return
        }
        
        let diff = value - start
        if diff.degrees > 10 {
            tetrisGameModel.rotateTetromino(clockwise: true)
            lastRotateAngle = value
            return
        } else if diff.degrees < -20 {
            tetrisGameModel.rotateTetromino(clockwise: false)
            lastRotateAngle = value
            return
        }
    }
    
    func onRotateEnd(value: RotationGesture.Value){
        lastRotateAngle = nil
    }
    
    func getMoveGesture()-> some Gesture{
        return DragGesture()
            .onChanged(onMoveChanged(value:))
            .onEnded(onMoveEnded(_:))
    }
    func onMoveChanged(value: DragGesture.Value){
        guard let start = lastMoveLocation else{
            lastMoveLocation = value.location
            return
        }
        let xDiff = value.location.x - start.x
        if xDiff > 10{
            print("Moving rigth")
            let _ = tetrisGameModel.moveTetrominoRigth()
            lastMoveLocation = value.location
            return
        }
        if xDiff < -10 {
            print("Moving left")
            let _ = tetrisGameModel.moveTetrominoLeft()
            lastMoveLocation = value.location
            return
        }
        let yDiff = value.location.y - start.y
        if yDiff > 10 {
            print("Moving down")
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            let _ = tetrisGameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            return
        }
        if yDiff < -10 {
            print("Dropping")
            tetrisGameModel.dropTetromino()
            lastMoveLocation = value.location
            return
        }
    }
    func onMoveEnded(_ : DragGesture.Value){
        lastMoveLocation = nil
    }
}

struct TetrisGameSquare {
    var color: Color
}
