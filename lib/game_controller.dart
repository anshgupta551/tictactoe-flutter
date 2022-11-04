import 'package:get/get.dart';

class Game extends GetxController {
  static final n = 5;
  static final boardlenth = n * n;
  static final blocSize = 100.0;

  List<List<RxString>> board = [];
  RxString result = "".obs;
  RxString lastValue = "X".obs;
  RxBool gameOver = false.obs;
  RxInt turn = 0.obs;

  void initialize_board()
  {

    for(int i=0;i<n;i++)
      {
        List<RxString> temp = [];
        for(int j=0;j<n;j++)
          {
            temp.add(" ".obs);
          }
        board.add(temp);
      }

    print(board);
  }

  bool exist(int index) {
    return ((index < n) && (index >= 0));
  }

  bool checkRowWin(int row, int col) {
    for(int i = 0; i < n; i++)
      {
        if(board[row][col].value != board[row][i].value)
          {
            return false;
          }
      }
    return true;
  }

  bool checkColWin(int row, int col) {
    for(int i = 0; i < n; i++)
    {
      if(board[row][col].value != board[i][col].value)
      {
        return false;
      }
    }
    return true;
  }

  bool checkRightDiagWin(int row, int col) {
    if(row!=col) return false;
    for(int i = 0; i < n; i++)
    {
      if(board[row][col].value != board[i][i].value)
      {
        return false;
      }
    }
    return true;
  }



  bool checkLeftDiagWin(int row, int col) {
    if(row+col != (n-1)) return false;
    for(int i = 0; i < n; i++)
    {
      if(board[row][col].value != board[n-i-1][i].value)
      {
        return false;
      }
    }
    return true;
  }

  bool winnerCheck(int index) {
    int row = index ~/ n;
    int col = index % n;

    if (checkRowWin(row, col) ||
        checkColWin(row, col) ||
        checkLeftDiagWin(row, col) ||
        checkRightDiagWin(row, col))
      return true;
    else
      return false;
  }
}
