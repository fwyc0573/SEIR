class GOL {
  int w = 8;
  int columns, rows;
  int N,E=0,I=0,S,R=0,r1=8,r2=8;
  float alpha=0.10,beta1=0.03,beta2=0.03,gamma=0.10;
  int A,B1,B2,G;
  Boolean isSuspend=false;
  
  // Game of life board
  int[][] board;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = (width-150)/w;
    rows = (height-150)/w;
    N=columns*rows;
    S=N-I;
    board = new int[columns][rows];
    //next = new int[columns][rows];
    // Call function to fill array with random values 0 or 1
    init();
  }

  void init() {
    for (int i =0;i < columns;i++) {
      for (int j =0;j < rows;j++) {
        board[i][j] = 0;
      }
    }
    //board[50][50] = 2;
  }
  
  void Count(){
    S=0;E=0;I=0;R=0;
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        if(board[x][y]==0) S++;
        else if(board[x][y]==1) E++;
        else if(board[x][y]==2) I++;
        else if(board[x][y]==3) R++;
      }
    }
  }
  
  // The process of creating the new generation
  void generate() {

    int[][] next = new int[columns][rows];

    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {

        // Add up all the states in a 3x3 surrounding grid
        int Sneighbors = 0,Eneighbors = 0,Ineighbors = 0,Rneighbors=0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            if(i!=0||j!=0){
              if(board[(x+i+columns)%columns][(y+j+rows)%rows]==0)
                 Sneighbors++;
              if(board[(x+i+columns)%columns][(y+j+rows)%rows]==1)
                 Eneighbors++;
              if(board[(x+i+columns)%columns][(y+j+rows)%rows]==2)
                 Ineighbors++;  
              if(board[(x+i+columns)%columns][(y+j+rows)%rows]==3)
                 Rneighbors++;  
            }
          }
        }
        
        
        A=int(1/alpha);
        G=int(1/gamma);
        B1=int(1/(beta1*Eneighbors));
        B2=int(1/(beta2*Ineighbors));
        // Rules of Life
        if      ((board[x][y] == 0) && (Eneighbors >  0)&&int(random(B1))==0) next[x][y] = 1;           //S→E，E传染
        else if ((board[x][y] == 0) && (Ineighbors >  0)&&int(random(B2))==0) next[x][y] = 1;           //S→E，I传染
        else if ((board[x][y] == 1)&&int(random(A))==0) next[x][y] = 2;           //E→I
        else if ((board[x][y] == 2)&&int(random(G))==0&&frameCount%int(random(10,40))==0) next[x][y] = 3;           //I→R,康复 
        else     next[x][y] = board[x][y];  // Stasis
      }
    }
int(random(255));
    // Next is now our board
    if(!isSuspend) board = next;
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns;i++) {
      for ( int j = 0; j < rows;j++) {
        if ((board[i][j] == 1)) fill(255,205,67);
        else if ((board[i][j] == 2)) fill(221,80,68);
        else if ((board[i][j] == 3)) fill(28,255,97);
        else if ((board[i][j] == 4)) fill(40,145,248);
        else fill(255); 
        stroke(255);
        
        rect(i*w, j*w, w, w);
               
      }
    }
  }
}
