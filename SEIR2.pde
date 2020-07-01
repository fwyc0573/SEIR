GOL gol;
boolean aPressed,b1Pressed,b2Pressed,gPressed,wall;
int suspendNumber=0;
boolean injectVaccine=false;
int coll = 950/8;
int roww = 650/8;
boolean can_draw = true;
int count =10;//记录帧数（涉及暂停不使用Framecount）
void setup() {
  //background(255);
  frameRate(20);
  size(950, 800);
  gol = new GOL();
  aPressed=false;
  
  //图例
  fill(0);//S
  line(7, 793, 7, 654);
  fill(0);//E
  line(7, 793, 7, 654);
  fill(0);//I
  line(7, 793, 7, 654);
  fill(0);//R
  line(7, 793, 7, 654);
  textSize(10);
  text("S", 800,120);
  text("E", 800,120);
  text("I", 800,120);
  text("R", 800,120);
 
}

void draw() {
  
 //清空指定区域
  for ( int i = 0; i < coll;i++) {
    for ( int j = 0; j < roww;j++) {
        stroke(255);
        fill(255); 
        rect(i*8, j*8, 8, 8);
      }
    }
    
    
 //绘制图表
 if(can_draw)
 {
 //坐标轴
 stroke(0);
 strokeWeight(2);
 line(7, 793, 7, 654);
 line(7, 654, 2, 673 );
 line(7, 793, 797, 793);
 line(797, 793, 782, 787);
 count++;
 // S
  stroke(255);
  fill(255);
  circle(count%800,790-0.0173*gol.S,1);
  //E
  stroke(255,205,67);
  fill(255,205,67);
  circle(count%800,790-0.0173*gol.E,1);
  //I
  stroke(221,80,68);
  fill(221,80,68);
  circle(count%800,790-0.0173*gol.I,1);
  //R
  stroke(28,255,97);
  fill(28,255,97);
  circle(count%800,790-0.0173*gol.R,1);
  //D
  stroke(156,2,167);
  fill(156,2,167);
  circle(count%800,790-0.0173*50,2);
  
  if(count%800 == 0)//清空图表区域
  {
    count +=10;
    print("清空");
   for ( int i = 0; i < 800;i++) {
    for ( int j = 650; j < 800;j++) {
        stroke(220);
        fill(220); 
        rect(i*1, j*1, 1, 1);
      }
    }
  }
 }
  gol.generate();
  gol.display();
  
  fill(0);
  textSize(20);
  gol.Count();
  
  
  text("S:"+gol.S, 810,20);
  text("E:"+gol.E, 810,45);
  text("I:"+gol.I, 810,70);
  text("R:"+gol.R, 810,95);
  
  text("--------------", 800,120);
  text("β1:"+gol.beta1, 810,145);
  text("β2:"+gol.beta2, 810,170);
  text("α:"+gol.alpha, 810,195);
  text("γ:"+gol.gamma, 810,220);
  textSize(15);
  text("Number",15, 670);
  text("Time",760, 780);
  //
    //图例
 //stroke(0);//S
 // line(825, 672, 875, 672);
 //stroke(0);//E
 // line(825, 702, 875, 702);
 //stroke(0);//I
 // line(825, 732, 875, 732);
 //stroke(0);//R
 // line(825, 762, 875, 762);
 //stroke(0);//D
 // line(825, 792, 875, 792);
 // textSize(20);
 // text("S", 895,680);
 // text("E", 895,710);
 // text("I", 895,740);
 // text("R", 895,770);
 // text("D", 895,795);
  
  if(injectVaccine){
    if(gol.board[mouseX/gol.w][mouseY/gol.w]==0)
         gol.board[mouseX/gol.w][mouseY/gol.w]=4;   //注射疫苗
  }
}


void keyPressed(){
  if(keyCode==32&&suspendNumber%2==0) {gol.isSuspend=true; suspendNumber++;can_draw = false;}
  else if(keyCode==32&&suspendNumber%2==1) {gol.isSuspend=false; suspendNumber++;can_draw = true;}
  if(keyCode==ENTER)  //回车，复原
  {
   gol.init();
   count = 10;
   for ( int i = 0; i < 800;i++) {
    for ( int j = 650; j < 800;j++) {
        stroke(255);
        fill(255); 
        rect(i*1, j*1, 1, 1);
      }
    }
  }
  if(keyCode==81) b1Pressed=true;    //q
  if(keyCode==87) b2Pressed=true;    //w
  if(keyCode==69) aPressed=true;     //e
  if(keyCode==82) gPressed=true;     //r
  if(keyCode==65) wall=true;         //a
  
  if(keyCode==UP){ 
    if(aPressed) {gol.alpha+=0.01; gol.alpha=constrain(gol.alpha,0.01,1);}
    if(b1Pressed) {gol.beta1+=0.01; gol.beta1=constrain(gol.beta1,0.01,1);}
    if(b2Pressed) {gol.beta2+=0.01; gol.beta2=constrain(gol.beta2,0.01,1);}
    if(gPressed) {gol.gamma+=0.01; gol.gamma=constrain(gol.gamma,0.01,1);}
  }
  if(keyCode==DOWN){
    if(aPressed) {gol.alpha-=0.01; gol.alpha=constrain(gol.alpha,0.01,1);}
    if(b1Pressed) {gol.beta1-=0.01; gol.beta1=constrain(gol.beta1,0.01,1);}
    if(b2Pressed) {gol.beta2-=0.01; gol.beta2=constrain(gol.beta2,0.01,1);}
    if(gPressed) {gol.gamma-=0.01; gol.gamma=constrain(gol.gamma,0.01,1);}
    
  }
  
}

void keyReleased(){
  if(keyCode==81) b1Pressed=false;    //q
  if(keyCode==87) b2Pressed=false;    //w
  if(keyCode==69) aPressed=false;     //e
  if(keyCode==82) gPressed=false;     //r
  if(keyCode==65) wall=false;
}


void mousePressed() {
  if(mouseX>0&&mouseX<800&&mouseY>0&&mouseY<650){
      if(mouseButton==LEFT){
        if(gol.board[mouseX/gol.w][mouseY/gol.w]==0)
         gol.board[mouseX/gol.w][mouseY/gol.w]=2;    //感染者
      }
      if(mouseButton==RIGHT){
        injectVaccine=true;
      }
  }
}

void mouseReleased(){
  if(mouseButton==RIGHT){
        injectVaccine=false;
      }
}
