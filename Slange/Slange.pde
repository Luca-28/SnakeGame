int[] SnakeX = new int[3];  //Sets up the Snake
int[] SnakeY = new int[3];

boolean Up = false;
boolean Left = false;
boolean Down = false;
boolean Right = true;

PImage SnakeHead;  //Defines the sprites
PImage SnakeEating;


String[] Food = {"Apple","Cherry","Banana","Strawberry","Mouse",};  //Sets up the fruit to collect
int FoodX;
int FoodY;
int CollectedFood = 0;
int SelectedFood = (int)random(0,5);
int Eating = 0;
PImage Apple;
PImage Cherry;
PImage Banana;
PImage Strawberry;
PImage Mouse;

String GameMode = "Menu";
String CurrentScreen = "Menu";

PImage NormalMode;
PImage InfiniteMode;


float Timer = 0;

void setup(){ 
  fullScreen();
  frameRate(30);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  noStroke();
  SnakeX[0] = width/2;    //Sets up the snake
  SnakeY[0] = height/2;
  SnakeX[1] = 0;
  SnakeX[2] = 0;
  SnakeY[1] = 0;
  SnakeY[2] = 0;
  
  SnakeHead = loadImage("SnakeHead.png");
  SnakeEating = loadImage("SnakeEating.png");
  
  
  FoodX = (int)random(10,width-10);  //Sets up the fruit
  FoodY = (int)random(110,height-10);
  
  Apple = loadImage("Apple.png");
  Cherry = loadImage("Cherry.png");
  Banana = loadImage("Banana.png");
  Strawberry = loadImage("Strawberry.png");
  Mouse = loadImage("Mouse.png");
  
  NormalMode = loadImage("NormalMode.png");
  InfiniteMode = loadImage("InfiniteMode.png");
  
}

void draw(){
  clear();
  background(120,150,30);
  if(CurrentScreen == "Menu"){  //Draws the gamemode selection menu
    background(50);
    textSize(30);
  
  fill(200);
  image(NormalMode,width/3,height/2);  //Draws the selection boxes
  fill(150);
  rect(width/3,height/2-200,300,100);
  fill(255);
  text("Normal Mode",width/3,height/2-200);
    
  fill(200);
  image(InfiniteMode,width-width/3,height/2);
  fill(150);
  rect(width-width/3,height/2-200,300,100);
  fill(255);
  text("Infinite Mode",width-width/3,height/2-200);
  
  
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
    fill(76,134,43);
    for(int i = SnakeX.length-1; i > 0; i--){  //Draws the snake and makes the tail follow
      circle(SnakeX[i],SnakeY[i],40);
      
      SnakeX[i] = SnakeX[i-1];
      SnakeY[i] = SnakeY[i-1];
    }
    //Draws the head of the snake
    pushMatrix();
    translate(SnakeX[0],SnakeY[0]);
    if(Up){
      rotate(radians(180));
    } else if(Left){
      rotate(radians(90));
    } else if(Down){
      rotate(radians(0));
    } else if(Right){
      rotate(radians(270));
    }
    if(dist(SnakeX[0],SnakeY[0],FoodX,FoodY) < 80){
      Eating = 2;
    }
    if(Eating > 0){
      image(SnakeEating,0,0);
      Eating--;
    } else {
      image(SnakeHead,0,0);
    }
    
    popMatrix();
    
    fill(150);  //Draws The HUD
    rect(width/2,50,width,100);
    fill(255);
    textSize(20);
    text("Press ENTER To Quit",200,40);
    text("WASD To Move",200,80);
    textSize(50);
    text("Score: " + CollectedFood,width/2,70);
    text("Time Passed: " + int(Timer) + " Seconds",1500,70);
    Timer += 1/frameRate;
    
    //Draws the fruit
    if(SelectedFood == 0){
      image(Mouse,FoodX,FoodY);
    } else if(SelectedFood == 1){
      image(Apple,FoodX,FoodY);
    } else if(SelectedFood == 2){
      image(Cherry,FoodX,FoodY);
    } else if(SelectedFood == 3){
      image(Strawberry,FoodX,FoodY);
    } else if(SelectedFood == 4){
      image(Banana,FoodX,FoodY);
    } else {
      circle(FoodX,FoodY,25);
    }
    
    if(SnakeX[0] > FoodX-30 && SnakeX[0] < FoodX+30  &&  SnakeY[0] > FoodY-30 && SnakeY[0] < FoodY+30){  //Checks if the snake eats fruit
      Eating = 5;
      CollectedFood++;
      SelectedFood = (int)random(0,5);
      println("Food Collected");
      int[] TempX = append(SnakeX,SnakeX[SnakeX.length-1]);
      SnakeX = TempX;
      
      int[] TempY = append(SnakeY,SnakeY[SnakeY.length-1]);
      SnakeY = TempY;
      
      for(int i = 0; i < 1; i++){
        FoodX = int(random(10,width-10));
        FoodY = int(random(110,height-10));
      }
    }
  } else if(CurrentScreen == "Game Over" || CurrentScreen == "Game Ended"){  //Draws the Results screen
    background(50);
    textSize(100);
    text(CurrentScreen,width/2,300);
    
    fill(150);
    rect(width/2,800,500,100);
    fill(255);
    textSize(75);
    text("Back to Menu",width/2,823);
    
    textSize(40);
    text("Score: " + CollectedFood,width/2,450);
    text("Time Passed: " + int(Timer) + " Seconds",width/2,550);
    
    
    if(mousePressed){  //Checks if the player presses "Back to Menu"
      if(mouseX > width/2-250 && mouseX < width/2+250  &&  mouseY > 750 && mouseY < 850){
        CurrentScreen = "Menu"; //Returns player to menu and resets all base values
        GameMode = "Menu";
        
        SnakeX[0] = width/2;
        SnakeY[0] = height/2;
        CollectedFood = 0;
        Timer = 0;
        
        Up = false;
        Left = false;
        Down = false;
        Right = true;
        
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
   if(key == 'w' && Down == false || key == 'W' && Down == false){
     Up = true;
     Left = false;
     Down = false;
     Right = false;
   }
   if(key == 'a' && Right == false || key == 'A' && Right == false){
     Up = false;
     Left = true;
     Down = false;
     Right = false;
   }
   if(key == 's' && Up == false || key == 'S' && Up == false){
     Up = false;
     Left = false;
     Down = true;
     Right = false;
   }
   if(key == 'd' && Left == false || key == 'D' && Left == false){
     Up = false;
     Left = false;
     Down = false;
     Right = true;
   }
   if(keyCode == ENTER){
    CurrentScreen = "Game Ended"; 
   }
  }
}
