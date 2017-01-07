/**
 * Granular FlyIn 
 * 
 * Built using Daniel Shiffman's "Explode" sketch as a base. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */
 
PImage img;       // The source image
int cellsize = 1; // Dimensions of each cell in the grid
int cols, rows;   // Number of columns and rows in our system
float frame = 40;
float[][] zArray;
float[][] bArray;

void setup() {
  img = loadImage("data/agoralogo2.jpg");  // Load the image
  size(img.width, img.height, P3D); 
  cols = img.width / cellsize / 2;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
  zArray = new float[cols][rows];
  bArray = new float[cols][rows];
  frameRate(24);
  for ( int q = 0; q < cols; q++) {
    for (int r = 0; r < rows; r++) {
      zArray[q][r] = random(50,100) * 0.1;
    }
  } 
  for ( int q = 0; q < cols; q++) {
    for (int r = 0; r < rows; r++) {
      bArray[q][r] = random(70,100) * 0.01;
    }
  } 
}

void draw() {
  background(0);
  if ( frame >= -40) {
  //Begin loop for columns
  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  // x position
      int y = j*cellsize + cellsize/2;  // y position
      int loc = x + y*img.width;  // Pixel array location
      color c = img.pixels[loc];  // Grab the color
      float z = frame*zArray[i][j];
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x, y, z);
      fill(c,brightness(img.pixels[loc])*bArray[i][j]*random(90,100)*0.01);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
      }
    }
    saveFrame("data/output/01/01_####.tif");
    frame = frame - (-8.5 * (1/(10*sqrt(TWO_PI))) * pow(2.71828, -pow((frame), 2)/40) + 0.5);
  }
  else {
    noLoop();
  }
}