PImage grass;
PImage tree;

Forest set1;

public class Forest {
  int x[];
  int y[];
  int numTrees;
  PImage trees[];

  public void randTrees() {
    for (int i=0; i<numTrees; i++)
    {
      this.x[i] = int(random(width));
      this.y[i] = int(random(height));
    }
  }

  public void drawTrees() {
    for (int i=0; i<numTrees; i++)
    {
      image(trees[i], x[i], y[i]);
    }
  }

  public Forest(int numCoords) {
    this.x = new int[numCoords];
    this.y = new int[numCoords];
    this.numTrees = numCoords;

    this.trees = new PImage[numCoords];
    for (int i=0; i<numCoords; i++)
    {
      this.trees[i] = tree;
    }

    for (int i=0; i<numCoords; i++)
    {
      this.x[i] = int(random(width));
      this.y[i] = int(random(height));
    }
  }
}

void setup()
{
  size(800, 800);

  grass = loadImage("grass.png");
  tree = loadImage("tree.png");

  image(grass, 0, 0);

  set1 = new Forest(10);
  set1.drawTrees();

  for (int i = 0; i<10; i++) {
    print(set1.x[i]);
    print(",");
    println(set1.y[i]);
  }
}

void draw()
{
}

void keyPressed() {
  set1.randTrees();
  image(grass, 0, 0);
  set1.drawTrees();
}
