import 'dart:math';

class MineSweeper {
  static int row = 6;
  static int col = 6;
  static int cells = row * col;
  bool gameOver = false;
  List<Cell> gameMap = [];
  static List<List<dynamic>> map = List.generate(
    row,
    (x) => List.generate(
      col,
      (y) => Cell(row: x, col: y, content: '', reveal: false),
    ),
  );

  void generateMap() {
    placeMines(10);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        gameMap.add(map[i][j]);
      }
    }
  }

  void placeMines(int minesNumber) {
    Random random = Random();
    for (int i = 0; i < minesNumber; i++) {
      int mineRow = random.nextInt(row);
      int mineCol = random.nextInt(col);
      map[mineRow][mineCol] = Cell(row: mineRow, col: mineCol, content: 'X', reveal: false);
    }
  }

  void showMinesOnGameOver() {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        if (map[i][j].content == 'X') {
          map[i][j].reveal = true;
        }
      }
    }
  }

  void onCellClicked(Cell cell) {
    if (cell.content == 'X') {
      showMinesOnGameOver();
      gameOver = true;
    } else {
      int mineCount = 0;
      int cellRow = cell.row;
      int cellCol = cell.col;

      for (int i = max(cellRow - 1, 0); i <= min(cellRow + 1, row - 1); i++) {
        for (int j = max(cellCol - 1, 0); j <= min(cellCol + 1, col - 1); j++) {
          if (map[i][j].content == 'X') {
            mineCount++;
          }
        }
      }
      cell.content = mineCount;
      cell.reveal = true;
      if (mineCount == 0) {
        for (int i = max(cellRow - 1, 0); i <= min(cellRow + 1, row - 1); i++) {
          for (int j = max(cellCol - 1, 0); j <= min(cellCol + 1, col - 1); j++) {
            if (map[i][j].content == '') {
              onCellClicked(map[i][j]);
            }
          }
        }
      }
    }
  }

  void resetGame() {
    map = List.generate(
      row,
      (x) => List.generate(
        col,
        (y) => Cell(row: x, col: y, content: '', reveal: false),
      ),
    );
    gameMap.clear();
    generateMap();
  }
}

class Cell {
  int row;
  int col;
  dynamic content;
  bool reveal = false;

  Cell({
    required this.row,
    required this.col,
    required this.content,
    required this.reveal,
  });
}
