
//--------------------------------------------------------------------------------------------------------------
//GLOBAL DATA

PImage outline;
PImage mountain;
PImage trunk;
PImage[] leaves = new PImage[3];
float[][] leafPos = { {0, 0}, {0, 0}, {0, 0} };
String[] leafNames = {"leaves3.png", "leaves1.png", "leaves2.png"}; //didn't want to rename files
PImage[] shadows = new PImage[3];
String[] shadowNames = {"shadow1.png", "shadow2.png", "shadow3.png"};
int whichShadow = 0;
PImage[] grasses = new PImage[3];
String[] grassNames = {"grass1.png", "grass2.png", "grass3.png"};
int whichGrass = 0;
int breezeFrame = 0;
//float[] breezePixels; at bottom for readability
PImage maskimg;
PImage[][] boxes = new PImage[3][3];
String[][] boxNames = {
  {"earth1.png", "earth2.png", "earth3.png"},
  {"riot1.png", "riot2.png", "riot3.png"},
  {"graph1.png", "graph2.png", "graph3.png"}
};
int[] currentBox = {0, 0, 0};
float[] positions = {0, 0, 0};
PGraphics sSource;
PGraphics sMask;
float myCount;
float windTimer;
float nightTimer;
int[] tintRGB={255, 255, 255};
//float[][] skycolors = {
//  {130, 225, 255,}
//};

//--------------------------------------------------------------------------------------------------------------
//SETUP

void setup() {
  size(1000, 1000);
  background(140, 240, 255);
  outline = loadImage("outline.png");
  trunk = loadImage("trunk.png");
  mountain = loadImage("mountain.png");
  for (int i=0; i<leafNames.length; i++) {
    leaves[i] = loadImage(leafNames[i]);
  }
  for (int i=0; i<shadowNames.length; i++) {
    shadows[i] = loadImage(shadowNames[i]);
  }
  for (int i=0; i<grassNames.length; i++) {
    grasses[i] = loadImage(grassNames[i]);
  }
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      boxes[i][j] = loadImage(boxNames[i][j]);
    }
  }

  maskimg = loadImage("innerMask.png");
  sSource = createGraphics(1000, 1000);

  sMask = createGraphics(1000, 1000);
  sMask.beginDraw();
  sMask.image(maskimg, 0, 0);
  sMask.endDraw();
}

//--------------------------------------------------------------------------------------------------------------
//MAIN

void draw() {

  scroll();
  cycleBoxes();
  windEffects();
  nightCycle();

  sSource.beginDraw();
  sSource.image(boxes[0][currentBox[0]], 0, positions[0]);
  sSource.image(boxes[1][currentBox[1]], 0, positions[1]);
  sSource.image(boxes[2][currentBox[2]], 0, positions[2]);
  sSource.endDraw();
  sSource.mask(sMask);

  drawSky();
  tint(tintRGB[0], tintRGB[1], tintRGB[2]);
  image(mountain, 0, 0);
  image(grasses[whichGrass], 0, 0);
  image(shadows[whichShadow], 0, 0);
  image(trunk, 0, 0);
  image(leaves[1], leafPos[1][0]-50, leafPos[1][1]-50);
  image(leaves[0], leafPos[0][0], leafPos[0][1]);
  image(leaves[2], leafPos[2][0], leafPos[2][1]);
  tint(255, 255, 255);
  drawBreeze();
  image(sSource, 0, 0);
  image(outline, 0, 0);

  myCount++;
  //windTimer++;
  nightTimer++;
}

//--------------------------------------------------------------------------------------------------------------
//PHONE

void scroll() {
  for (int i=0; i<boxes.length; i++) {
    positions[i] = (((myCount/60)*800*1)+i*400)%1200-600;
  }
}

void cycleBoxes() {
  for (int i=0; i<currentBox.length; i++) {
    if (myCount % 15 == i*5) {
      currentBox[i] = (currentBox[0]+1)%(currentBox.length);
    }
  }
}

//--------------------------------------------------------------------------------------------------------------
//WIND

void windEffects() {
  windTimer = myCount %300;
  if (windTimer == 0) { //ugly but it works
    breezeFrame = -100;
  }
  blowLeaves();
  changeShadow();
  swayGrass();
  //drawBreeze();
}

void blowLeaves() {
  switch(int(windTimer)) {
  case 1: //right leaves
    leafPos[0][1] = -10;
    break;
  case 20:
    leafPos[0][1] = 0;
    break;
  case 11: //top leaves
    leafPos[1][0] = -10;
    //leafPos[1][1] = 10;
    break;
  case 30:
    leafPos[1][0] = 0;
    leafPos[1][1] = 0;
    break;
  case 21: // left leaves
    leafPos[2][0] = -10;
    break;
  case 40:
    leafPos[2][0] = 0;
    break;
    //big sway
  case 101: //right leaves
    leafPos[0][1] = -20;
    break;
  case 140:
    leafPos[0][1] = 0;
    break;
  case 111: //top leaves
    leafPos[1][0] = -20;
    //leafPos[1][1] = 10;
    break;
  case 150:
    leafPos[1][0] = 0;
    leafPos[1][1] = 0;
    break;
  case 121: //left leaves
    leafPos[2][0] = -20;
    break;
  case 160:
    leafPos[2][0] = 0;
  }
}

void changeShadow() {
  switch(int(windTimer)) {
  case 1:
    whichShadow = 1;
    break;
  case 20:
    whichShadow = 2;
    break;
  case 40:
    whichShadow = 0;
    break;
  case 101:
    whichShadow = 1;
    break;
  case 130:
    whichShadow = 2;
    break;
  case 160:
    whichShadow = 0;
    break;
  }
}

void swayGrass() {
  switch(int(windTimer)) {
  case 35:
    whichGrass = 1;
    break;
  case 50:
    whichGrass = 2;
    break;
  case 65:
    whichGrass = 0;
    break;
  case 120:
    whichGrass = 1;
    print("sway");
    break;
  case 130:
    whichGrass = 2;
    break;
  case 140:
    whichGrass = 0;
    break;
  case 150:
    whichGrass = 1;
    break;
  case 160:
    whichGrass = 2;
    break;
  case 170:
    whichGrass = 1;
    break;
  case 180:
    whichGrass = 0;
    break;
  }
}

void drawBreeze() {
  if (breezeFrame + 9 < breezePixels.length && breezeFrame >=0) {
    for (int i=0; i<10; i++) {
      drawPixel(breezePixels[i+breezeFrame][0], breezePixels[i+breezeFrame][1]);
    }
  }
  breezeFrame++;
}

void drawPixel(float x, float y) {
  if (!(x ==0 && y ==0)) {
    noStroke();
    fill(255);
    square(x*10, y*10, 10);
  }
}
//--------------------------------------------------------------------------------------------------------------
//NIGHT

void nightCycle() {
  //changesky
  //tintVals
}

void drawSky() {
  background(130, 225, 255);
}
//--------------------------------------------------------------------------------------------------------------

float[][] breezePixels =
  {


  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},

  {83, 35},
  {82, 35},
  {81, 35},
  {80, 35},
  {79, 34},
  {78, 34},
  {77, 34},
  {76, 33},
  {75, 33},
  {74, 32},
  {73, 32},
  {72, 33},
  {71, 33},
  {70, 33},
  {69, 34},
  {68, 34},
  {67, 34},
  {66, 35},
  {65, 35},
  {64, 35},
  {63, 35},
  {62, 35},
  {61, 35},
  {60, 35},
  {59, 35},
  {58, 35},
  {57, 35},
  {56, 35},
  {55, 35},
  {54, 35},
  {53, 35},
  {52, 35},
  {51, 35},
  {50, 35},
  {49, 35},
  {48, 35},
  {47, 35},
  {46, 35},
  {45, 35},
  {44, 35},
  {43, 35},
  {42, 35},
  {41, 35},
  {40, 35},
  {39, 35},
  {38, 35},
  {37, 35},
  {36, 35},
  {35, 35},
  {34, 35},
  {33, 35},
  {32, 35},
  {31, 35},
  {30, 35},
  {29, 35},
  {28, 35},
  {27, 35},
  {26, 34},
  {25, 34},
  {24, 34},
  {23, 33},
  {22, 33},
  {21, 33},
  {20, 32},
  {19, 32},
  {18, 32},
  {17, 32},
  {16, 32},
  {15, 33},
  {14, 33},
  {13, 33},
  {12, 34},
  {11, 34},
  {10, 35},
  {9, 35},
  {8, 36},
  {7, 36},
  {6, 36},
  {5, 35},
  {4, 34},
  {4, 33},
  {3, 32},
  {3, 31},
  {4, 30},
  {4, 29},
  {5, 28},
  {6, 28},
  {7, 27},
  {8, 27},
  {9, 28},
  {10, 29},
  {10, 30},
  {9, 31},
  {8, 32},
  {7, 32},

  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},

};
