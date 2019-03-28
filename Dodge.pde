float X;
float Y;
float Xvel;
float Yvel;

boolean left;
boolean up;
boolean right;
boolean down;

float increment = 0.15;
float decrement = 0.93;

int lives = 5; 
int score = 0;
int playerSize = 5;
int partSize = 10;
ArrayList<Particle> particles;
float randVmax = 0.5;

void setup()
{
  particles = new ArrayList<Particle>();

  size(640, 360);
  X = width / 2;
  Y = height / 2;
}

void draw()
{
  background(50);

  noStroke();

  if ((int)random(1, 3) == 1)
  {
    switch (int(random(5)))
    {
    case 0:
      particles.add(new Particle(partSize/2, random(partSize/2, height - partSize/2), random(0, randVmax), random(-randVmax, randVmax)));
      break;
    case 1:
      particles.add(new Particle(width - partSize/2, random(partSize/2, height - partSize/2), random(-randVmax, 0), random(-randVmax, randVmax)));
      break;
    case 2:
      particles.add(new Particle(random(partSize/2, width - partSize/2), partSize/2, random(-randVmax, randVmax), random(0, randVmax)));
      break;
    case 4:
      particles.add(new Particle(random(partSize/2, width - partSize/2), height - partSize/2, random(-randVmax, randVmax), random(-randVmax, 0)));
      break;
    }
    score++;
  }

  for (int i = particles.size() - 1; i >= 0; i--) 
  {
    Particle part = particles.get(i);

    if (part.x < partSize/2 || part.x > (width - partSize/2))
    {
      particles.remove(i);
      //part.vx *= -1;
    } else if (part.y < partSize/2 || part.y > (height - partSize/2))
    {
      particles.remove(i);

      //part.vy *= -1;
    }

    part.x += part.vx;
    part.y += part.vy;
    fill(0, 255, 255);
    stroke(255, 255, 0);
    ellipse(part.x, part.y, partSize, partSize);

    if (part.x-partSize/2 < X+playerSize/2 && part.x+partSize/2 > X-playerSize/2)
    {
      if (part.y-partSize/2 < Y+playerSize/2 && part.y+partSize/2 > Y-playerSize/2)
      {
        particles.remove(i);
        lives--;
        background(255, 0, 0);
      }
    }

    fill(255, 0, 0);
    textSize(20);
    text(lives + " <3", 0, 20);

    if (lives == 0)
    {
      println("You died!");
      println("Your score is: " + score);
      while (true)
      {
      }
    }
  }


  if (left)
    Xvel -= increment;
  if (up)
    Yvel -= increment;
  if (right)
    Xvel += increment;
  if (down)
    Yvel += increment;

  Yvel *= decrement;
  Xvel *= decrement;

  X += Xvel;
  Y += Yvel;

  if (X < 0)
    X += width;
  else if (X > width)
    X -= width;
  if (Y < 0)
    Y += height;
  else if (Y > height)
    Y -= height;

  rectMode(CENTER);
  fill(255);
  noStroke();
  rect(X, Y, playerSize, playerSize);
}

void keyPressed()
{
  if (keyCode == 37)
    left = true;
  else if (keyCode == 38)
    up = true;
  else if (keyCode == 39)
    right = true;
  else if (keyCode == 40)
    down = true;
}

void keyReleased()
{
  if (keyCode == 37)
    left = false;
  else if (keyCode == 38)
    up = false;
  else if (keyCode == 39)
    right = false;
  else if (keyCode == 40)
    down = false;
}
