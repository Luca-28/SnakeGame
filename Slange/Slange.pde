int[] SnakeX = new int[3];  //Sets up the Snake
int[] SnakeY = new int[3];

boolean Up = false;
boolean Left = false;
boolean Down = false;
boolean Right = true;


String[] Fruit = {"Apple","Cherry","Banana"};  //Sets up the fruit to collect
int FruitX;
int FruitY;
int CollectedFruit = 0;


String GameMode = "Menu";
String CurrentScreen = "Menu";


float Timer = 0;
void setup(){ 
  fullScreen();
  frameRate(30);
  rectMode(CENTER);
  textAlign(CENTER);
  
  SnakeX[0] = width/2;    //Sets up the snake at the starting position
  SnakeY[0] = height/2;
  SnakeX[1] = 0;
  SnakeX[2] = 0;
  SnakeY[1] = 0;
  SnakeY[2] = 0;
  
  FruitX = (int)random(10,width-10);  //Sets up the fruit
  FruitY = (int)random(110,height-10);
}

void draw(){
  clear();
  background(50);
  if(CurrentScreen == "Menu"){  //Draws the gamemode selection menu
  
  textSize(30);
  
  fill(200);
  rect(width/3,height/2,300,300);  //Draws the selection boxes
  fill(150);
  rect(width/3,height/2-100,300,100);
  fill(255);
  text("Normal Mode",width/3,height/2-100);
    
  fill(200);
  rect(width-width/3,height/2,300,300);
  fill(150);
  rect(width-width/3,height/2-100,300,100);
  fill(255);
  text("Infinite Mode",width-width/3,height/2-100);
  
  
  if(mousePressed){  //Checks the clicked box
    if(mouseX > width/3-150 && mouseX < width/3+150 && mouseY > height/2-150 && mouseY < height/2+150){
      GameMode = "Normal";
      CurrentScreen = "Game";
    } else if(mouseX > width-width/3-150 && mouseX < width-width/3+150 && mouseY > height/2-150 && mouseY < height/2+150){
      GameMode = "Infinite";
      CurrentScreen = "Game";
    }
  }
  
    
  } else if(CurrentScreen == "Game"){
    
    if(Up){  //Moves the snake
      SnakeY[0] -= 20;
    } else if(Left){
      SnakeX[0] -= 20;
    } else if(Down){
      SnakeY[0] += 20;
    } else if(Right){
      SnakeX[0] += 20;
    }
    
    if(GameMode == "Infinite"){  //Loops the snake around when crossing the edge
      if(SnakeX[0] > width){
        SnakeX[0] = 0;
      } else if(SnakeX[0] < 0){
        SnakeX[0] = width;
      }
      if(SnakeY[0] > height){
        SnakeY[0] = 100;
      } else if(SnakeY[0] < 100){
        SnakeY[0] = height;
      }
    } else if(GameMode == "Normal"){  //Kills the player when crossing the edge
    if(SnakeX[0] > width || SnakeX[0] < 0 || SnakeY[0] > height || SnakeY[0] < 100){
      CurrentScreen = "Game Over";
      println("Game Over (Player hit the edge)");
    }
    for(int i = 1; i < SnakeX.length; i++){  //Kills the player when hitting themselves
      if(SnakeX[0] > SnakeX[i] - 5 && SnakeX[0] < SnakeX[i] + 5 && SnakeY[0] > SnakeY[i] - 5 && SnakeY[0] < SnakeY[i] + 5){
        CurrentScreen = "Game Over";
        println("Game Over (Player hit themselves)");
      }
    }
    }
    fill(50,200,50);
    for(int i = SnakeX.length-1; i > 0; i--){  //Draws the snake and makes the tail follow
      circle(SnakeX[i],SnakeY[i],25);
      
      SnakeX[i] = SnakeX[i-1];
      SnakeY[i] = SnakeY[i-1];
    }
    circle(SnakeX[0],SnakeY[0],30);  //Draws the head of the snake
    
    fill(150);  //Draws The HUD
    rect(width/2,50,width,100);
    fill(255);
    textSize(50);
    text("Fruits Collected: " + CollectedFruit,300,70);
    text("Time Passed: " + int(Timer) + " Seconds",1300,70);
    Timer += 1/frameRate;
    
    fill(255);
    circle(FruitX,FruitY,20);  //Draws the fruit
    
    if(SnakeX[0] > FruitX-30 && SnakeX[0] < FruitX+30  &&  SnakeY[0] > FruitY-30 && SnakeY[0] < FruitY+30){  //Checks if the snake eats fruit
      CollectedFruit++;
      println("Fruit Collected");
      int[] TempX = append(SnakeX,SnakeX[SnakeX.length-1]);
      SnakeX = TempX;
      
      int[] TempY = append(SnakeY,SnakeY[SnakeY.length-1]);
      SnakeY = TempY;
      
      for(int i = 0; i < 1; i++){
        FruitX = int(random(10,width-10));
        FruitY = int(random(110,height-10));
        for(int o = SnakeX.length; i > 0; o--){
          if(FruitX > SnakeX[o]-30 && FruitX < SnakeX[o]+30  &&  FruitY > SnakeY[o]-30 && FruitY < SnakeY[o]+30){  //Makes sure the fruit doesn't spawn on the snake
            i--;
            println("Available position for fruit not found. Retrying");
          }
        }
      }
    }
  } else if(CurrentScreen == "Game Over"){  //Draws the Game Over screen
    textSize(100);
    text("Game Over",width/2,300);
    
    fill(150);
    rect(width/2,800,500,100);
    fill(255);
    textSize(75);
    text("Back to Menu",width/2,823);
    
    textSize(40);
    text("Fruit Collected: " + CollectedFruit,width/2,450);
    text("Time Passed: " + int(Timer) + " Seconds",width/2,550);
    
    if(mousePressed){  //Checks if the player presses "Back to Menu"
      if(mouseX > width/2-250 && mouseX < width/2+250  &&  mouseY > 750 && mouseY < 850){
        CurrentScreen = "Menu"; //Returns player to menu and resets all base values
        GameMode = "Menu";
        
        SnakeX[0] = width/2;
        SnakeY[0] = height/2;
        CollectedFruit = 0;
        Timer = 0;
        
        int[] TempX = SnakeX;
        int[] TempY = SnakeY;
        
        for(int i = SnakeX.length; i > 3; i--){
          TempX = shorten(SnakeX);
          SnakeX = TempX;
          TempY = shorten(SnakeY);
          SnakeY = TempY;
          
        }
      }
    }
  }
}

void keyPressed(){  //Changes the snake direction
if(CurrentScreen == "Game"){
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
   if(key == 'd' && Left == false){
     Up = false;
     Left = false;
     Down = false;
     Right = true;
   }
  }
}
