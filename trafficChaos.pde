int numberOfWalkers = 3;
float walkerMaxSpeed = 0.8;
float walkerMaxForce = 0.02;

boolean debug = true;
boolean mpressed = false;

String state = "MAKE_PATH1";

Path path1, path2;

Car car1, car2;

ArrayList<Walker> walkers;
TrafficLight light1, light2;

PImage bg;

void setup() {
  size(1772, 1772);
  
  bg = loadImage("images/bakgrund.jpg");

  path1 = new Path();
  path2 = new Path();

  car1 = new Car(new PVector(0, height/2), 2, 0.04);
  car2 = new Car(new PVector(0, height/2), 3, 0.1);

  walkers = new ArrayList<Walker>();

  for (int i = 0; i < numberOfWalkers; i++){
    walkers.add(new Walker(new PVector(random(0,width), random(0,height)), walkerMaxSpeed, walkerMaxForce));
  }

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(800, 300);
}

void draw() {
  background(bg);

  switch(state) {

    //*********MAKE_PATH1**********
    case("MAKE_PATH1"):
    if (mousePressed && !mpressed) {
      path1.addPoint(mouseX, mouseY);
      mpressed = true;
    } else {
      mpressed = false;
    }
    if (keyPressed && key == '1') {
      state = "MAKE_PATH2";
    }  
    path1.render();   
    break;

    //*********MAKE_PATH2**********
    case("MAKE_PATH2"):
    if (mousePressed && !mpressed) {
      path2.addPoint(mouseX, mouseY);
      mpressed = true;
    } else {
      mpressed = false;
    }
    if (keyPressed && key == '2') {
      state = "RUN";
    }
    path1.render();
    path2.render();  
    break;

    //*********RUN**********
    case("RUN"):

    car1.follow(path1);
    car2.follow(path1);

    for (int i = 0; i < walkers.size(); i++) {
      Walker walker = walkers.get(i);
      walker.follow(path2);
      walker.run();
    }

    car1.run();
    car2.run();
    car1.checkCollision(walkers);
    car2.checkCollision(walkers);


    light1.update();
    light2.update();
    break;


    //**********GAME_OVER*************
    case("GAME_OVER"):
    background(0);
    textSize(100);
    fill(255);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    break;
  }
}

public void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}
