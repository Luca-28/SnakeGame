int[] SlangedeleX = {100,120,140};
int[] SlangedeleY = {100,100,100};

boolean Up = false;
boolean Left = false;
boolean Down = false;
boolean Right = false;

void setup(){ 
  size(1000,1000);
  
}

void draw(){
  clear();
  background(50);
  
  for(int i = SlangedeleX.length-1; i > 0; i--){
    SlangedeleX[i] = SlangedeleX[i-1];
    SlangedeleY[i] = SlangedeleY[i-1];
  }
  if(Up){  //Moves the snake
    SlangedeleY[0] -= 20; 
  } else if(Left){
    SlangedeleX[0] -= 20;
  } else if(Down){
    SlangedeleY[0] += 20;
  } else if(Right){
    SlangedeleX[0] += 20;
  }
  
  if(SlangedeleX[0] > 1000){  //Loops the snake around when crossing the edge
    SlangedeleX[0] = 0;
  } else if(SlangedeleX[0] < 0){
    SlangedeleX[0] = 1000;
  }
  if(SlangedeleY[0] > 1000){
    SlangedeleY[0] = 0;
  } else if(SlangedeleY[0] < 0){
    SlangedeleY[0] = 1000;
  }
  
  fill(255);
  for(int i = 0; i < SlangedeleX.length; i++){    //Draws the snake
    circle(SlangedeleX[i],SlangedeleY[i],20);
  }
}

void keyPressed(){  //Changes the snake direction
 if(key == 'w' && Down == false){
   Up = true;
   Left = false;
   Down = false;
   Right = false;
 }
 if(key == 'a' && Right == false){
   Up = false;
   Left = true;
   Down = false;
   Right = false;
 }
 if(key == 's' && Up == false){
   Up = false;
   Left = false;
   Down = true;
   Right = false;
 }
 if(key == 'd' == Left == false){
   Up = false;
   Left = false;
   Down = false;
   Right = true;
 }
}
