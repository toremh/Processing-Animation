PImage outline;
PImage mountain;
PImage grass;
PImage trunk;
PImage leaves1;
PImage leaves2;
PImage leaves3;
PImage maskimg;
PImage scribble;
PImage[][] boxes = new PImage[3][3];
String[][] boxNames = {
  {"box1a.png", "box1b.png", "box1c.png"},
  {"box2.png", "box2.png", "box2.png"},
  {"box3.png", "box3.png", "box3.png"}
};
int[] currentBox = {0,0,0};
float[] positions = {0, 0, 0};
PGraphics sSource;
PGraphics sMask;
float myCount;

void setup() {
  size(1000, 1000);
  background(140, 240, 255);
  //outline = loadImage("200outline.png");
  outline = loadImage("outline.png");
  grass = loadImage("grassrough.png");
  trunk = loadImage("trunk.png");
  leaves1 = loadImage("leaves1.png");
  leaves2 = loadImage("leaves2.png");
  leaves3 = loadImage("leaves3.png");
  mountain = loadImage("mountain.png");
  scribble = loadImage("scribble.png");
  //boxes[0] = loadImage("box1.png");
  //boxes[1] = loadImage("box2.png");
  //boxes[2] = loadImage("box3.png");
  //print(boxNames.length);
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      boxes[i][j] = loadImage(boxNames[i][j]);
    }
  }

  maskimg = loadImage("innerMask.png");
  //scribble.mask(maskimg);

  sSource = createGraphics(1000, 1000);


  sMask = createGraphics(1000, 1000);
  sMask.beginDraw();
  sMask.image(maskimg, 0, 0);
  sMask.endDraw();

  //image(scribble, 0, 0);
  //image(boxes[0],0,-400);
}


void draw() {

  //scroll();
  //cycleBoxes();

  sSource.beginDraw();
  sSource.image(boxes[0][currentBox[0]], 0, positions[0]);
  sSource.image(boxes[1][currentBox[1]], 0, positions[1]);
  sSource.image(boxes[2][currentBox[2]], 0, positions[2]);
  sSource.endDraw();
  sSource.mask(sMask);

  image(mountain, 0, 0);
  image(grass, 0, 0);
  image(trunk, 0, 0);
  image(leaves1, 0, 0);
  image(leaves2, 0, 0);
  image(leaves3, 0, 0);
  image(sSource, 0, 0);
  image(outline, 0, 0);


  myCount++;
}

void scroll() {
  for (int i=0; i<boxes.length; i++) {
    positions[i] = (((myCount/60)*800*1)+i*400)%1200-600;
    //println(positions[0]);
  }
}

void cycleBoxes() {
  for (int i=0; i<currentBox.length; i++) {
    if (myCount % 15 == i*5) {
      currentBox[i] = (currentBox[0]+1)%(currentBox.length);
      print(currentBox[i]);
    }
  }
}
