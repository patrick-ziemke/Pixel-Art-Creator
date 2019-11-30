//Project Title: Image Pixelator (FINAL PROJECT)
//By: Patrick Ziemke
//
//CSI 100 - The Joy of Computing
//Professor S. Petit
//
//This program takes input of either a JPG or PNG image from
//your filesystem, and pixelates it to your choosing through
//a slider object. To start, choose the image you would like
//to pixelate, then move the slider to your desired pixelation.
//
//Copyright (c) 2019 Patrick Ziemke


import java.io.File; //imports Java class "File"
PImage img;
PImage outputImg;

//slider variables
float slider_width = 50;
float slider_height = 10;
float posx, posy;
boolean over = false;
boolean locked = false;
float xoff;
float fundo;

//creates PFont
PFont font, font2;

void setup() {
  size(1024, 640);
  selectInput("Select an image: ", "imageChosen"); //runs imageChosen method (below)

  //slider positioning
  posx = width/4;
  posy = height - 100;
  rectMode(CENTER);

  //sets font variable to Courier New Bold
  font = loadFont("CourierNewPS-BoldMT-48.vlw");
  font2 = loadFont("CourierNewPS-BoldMT-18.vlw");
  //textFont(font);
}

void draw() {
  //Environment Configuration
  fundo = posx;
  background(52);
  fill(255);

  //Title Text
  textFont(font);
  text("Pixel Art Creator", (width/3)-65, 50);
  text(" For Beginners", (width/3)-50, 100);
  strokeWeight(3);
  stroke(255);

  //Filter buttons
  //Threshold Filter
  fill(0);
  rect(100, 100, 100, 100);

  //Grayscale Filter
  fill(92, 92, 92);
  rect(100, 250, 100, 100);

  //Invert Filter
  fill(29, 152, 196);
  rect(100, 400, 100, 100);

  //Posterize Filter
  fill(255, 176, 38);
  rect(100, 550, 100, 100);

  //Blur Filter
  fill(66, 206, 245);
  rect(width-100, 100, 100, 100);

  //Erode Filter
  fill(124, 68, 201);
  rect(width-100, 250, 100, 100);

  //Reset Filters
  fill(240, 37, 34);
  rect(width-100, 550, 100, 100);

  textFont(font2);
  fill(255);
  text("Threshold", 50, 100);
  text("Grayscale", 50, 250);
  text(" Invert ", 50, 400);
  text("Posterize", 50, 550);
  text("  Blur  ", 875, 100);
  text(" Erode ", 875, 250);
  text("Reset All", 875, 550);
  text("Pixelation", width/2-75, 580);

  //slider bar line configuration
  line ((width/4)+50, posy, ((width/4)*3)-110, posy);
  fill(13, 129, 224);

  //Slider Control
  if (dist(mouseX, mouseY, posx+306, posy) < slider_height) {
    fill(200);
    over = true;
  } else {
    fill(255);
    over = false;
  }
  if (posx < 20) {
    println ("ERROR");
    posx = 20;
  }
  if (posx > 330) {
    println ("ERROR");
    posx = 330;
  }
  fill(13, 129, 224);
  rect(posx + 306, posy, slider_width, slider_height); //slider body

  if (img != null) {
    
    img.resize(width/2, height/2); //resizes image to half-size
    img.loadPixels();
    for (int x = 0; x < img.width; x += (posx / 15)) { //columns
      for (int y = 0; y < img.height; y += (posx / 15)) { //rows
        color c = img.pixels[y * img.width + x]; //finds average color for block (pixels[] array)
        noStroke();
        fill(c); //fills color with average for that block
        rect(x + (width/4), y + (height/4), 10, 10); //draws image in pixels
      }
    }
    img.updatePixels(); //updates display window with data from pixels[] array
  }
  
  //Filter Controls
  if (mousePressed == true && mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 150) {
    println("Filter = Threshold");
    img.filter(THRESHOLD);
    delay(100);
  } else if (mousePressed == true && mouseX > 50 && mouseX < 150 && mouseY > 200 && mouseY < 300) {
    println("Filter = Gray");
    img.filter(GRAY);
    delay(100);
  } else if (mousePressed == true && mouseX > 50 && mouseX < 150 && mouseY > 350 && mouseY < 450) {
    println("Filter = Invert");
    img.filter(INVERT);
    delay(100);
  } else if (mousePressed == true && mouseX > 50 && mouseX < 150 && mouseY > 500 && mouseY < 600) {
    println("Filter = Posterize");
    img.filter(POSTERIZE, 4);
    delay(100);
  } else if (mousePressed == true && mouseX > 875 && mouseX < 975 && mouseY > 50 && mouseY < 150) {
    println("Filter = Blur");
    img.filter(BLUR);
    delay(100);
  } else if (mousePressed == true && mouseX > 875 && mouseX < 975 && mouseY > 200 && mouseY < 300) {
    println("Filter = Erode");
    img.filter(ERODE);
    delay(100);
  } else if (mousePressed == true && mouseX > 875 && mouseX < 975 && mouseY > 500 && mouseY < 600) {
    println("CLEAR");
    delay(1000);
    setup();
  }
}

void imageChosen(File imageFile) { //imageChosen method, takes File parameter
  if (imageFile.exists()) {
    img = loadImage(imageFile.getAbsolutePath()); //loads image from user's filesystem
  }
}

//methods for slider control when dragging bar
void mousePressed() {
  if (over) {
    locked = true;
    xoff = mouseX-posx;
  }
}
void mouseDragged() {
  if (locked) {
    posx = mouseX-xoff;
  }
}
void mouseReleased() {
  locked = false;
}
