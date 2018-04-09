// do this first: 
// http://code.google.com/p/simple-openni/wiki/Installation
// http://www.sojamo.de/libraries/oscP5/

import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;

OscP5 whereimlistening; // equivalent to [udpreceive] in max, e.g. it's listening
NetAddress whereimsending; // equivalent to [udpsend] in max - it's sending
String messageselector;

SimpleOpenNI  c;

PFont f;

int i;

void setup()
{

  f = loadFont("Monospaced-48.vlw");
  textFont(f);
  textSize(24);
  textAlign(LEFT);

  c = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  if(c.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // set mirror
  c.setMirror(true);

  // enable depthMap generation 
  c.enableDepth();
   
  // enable skeleton generation for all joints
  c.enableUser();

  // set the size to both
  size(c.depthWidth(), c.depthHeight());

  // do the OSC setup stuff
  whereimlistening = new OscP5(this, 12000);
  whereimsending = new NetAddress("127.0.0.1", 8000); // hostname, port

}

void draw()
{
  // get a new frame
  c.update();

  background(0, 0, 0);

  // draw depthImageMap
  tint(255, 0, 0);
  image(c.depthImage(), 0, 0);
  noTint();

  // draw the skeleton if it's available
  int[] userList = c.getUsers();
  for (int i=0;i<userList.length;i++)
  {
    if (c.isTrackingSkeleton(userList[i]))
    {
      drawSkeleton(userList[i]);
      sendEverything(userList[i]);
    }
  }
}

void sendEverything(int userId)
{
  // to get the 3d joint data
  PVector temp = new PVector(0, 0, 0);
  OscMessage themessage;

// HEAD, NECK, TORSO
// LEFTHAND, RIGHTHAND, LEFTELBOW, RIGHTELBOW 
// LEFTSHOULDER, RIGHTSHOULDER
// LEFTHIP, RIGHTHIP, LEFTKNEE, RIGHTKNEE
// LEFTFOOT, RIGHTFOOT

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, temp);
  themessage = new OscMessage("/head");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, temp);
  themessage = new OscMessage("/neck");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);
 
  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, temp);
  themessage = new OscMessage("/torso");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, temp);
  themessage = new OscMessage("/lefthand");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, temp);
  themessage = new OscMessage("/righthand");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, temp);
  themessage = new OscMessage("/leftelbow");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, temp);
  themessage = new OscMessage("/rightelbow");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, temp);
  themessage = new OscMessage("/leftshoulder");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, temp);
  themessage = new OscMessage("/rightshoulder");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, temp);
  themessage = new OscMessage("/lefthip");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, temp);
  themessage = new OscMessage("/righthip");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, temp);
  themessage = new OscMessage("/leftknee");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, temp);
  themessage = new OscMessage("/rightknee");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, temp);
  themessage = new OscMessage("/leftfoot");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, temp);
  themessage = new OscMessage("/rightfoot");
  themessage.add(temp.x);
  themessage.add(temp.y);
  themessage.add(temp.z);
  whereimlistening.send(themessage, whereimsending);
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{

  stroke(0, 0, 255);
  noFill();
  strokeWeight(2);
  // to get the 3d joint data
  PVector temp = new PVector(0, 0, 0);

  // draw head and hands
  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 20, 20);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 50, 50);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 10, 10);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 10, 10);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 20, 20);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 20, 20);

  c.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  c.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  c.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  c.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  c.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);

}

// these are the SKELETON CALLBACKS

// user steps in
void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);

  curContext.startTrackingSkeleton(userId);
}

// user gets lost
void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

// user walks out
void onExitUser(int userId)
{
  println("onExitUser - userId: " + userId);
}

// SAME user comes back in
void onReEnterUser(int userId)
{
  println("onReEnterUser - userId: " + userId);
}

// calibration
void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    c.startTrackingSkeleton(userId); // start tracking
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
  }
}

float getDistance(PVector a, PVector b)
{
  float d = (a.x-b.x)*(a.x-b.x); 
  d += (a.y-b.y)*(a.y-b.y); 
  d += (a.z-b.z)*(a.z-b.z); 
  d = sqrt(d);
  //println("getting distance... " + d);
  return(d);
}

void keyPressed()
{
 
}



int mapnames(String f)
{
  int out = 0;
   if(f.equals("HEAD")) out = SimpleOpenNI.SKEL_HEAD;
   if(f.equals("NECK")) out = SimpleOpenNI.SKEL_NECK;
   if(f.equals("TORSO")) out = SimpleOpenNI.SKEL_TORSO;
   if(f.equals("LEFTHAND")) out = SimpleOpenNI.SKEL_LEFT_HAND;
   if(f.equals("RIGHTHAND")) out = SimpleOpenNI.SKEL_RIGHT_HAND;
   if(f.equals("LEFTELBOW")) out = SimpleOpenNI.SKEL_LEFT_ELBOW;
   if(f.equals("RIGHTELBOW")) out = SimpleOpenNI.SKEL_RIGHT_ELBOW;
   if(f.equals("LEFTSHOULDER")) out = SimpleOpenNI.SKEL_LEFT_SHOULDER;
   if(f.equals("RIGHTSHOULDER")) out = SimpleOpenNI.SKEL_RIGHT_SHOULDER;
   if(f.equals("LEFTHIP")) out = SimpleOpenNI.SKEL_LEFT_HIP;
   if(f.equals("RIGHTHIP")) out = SimpleOpenNI.SKEL_RIGHT_HIP;
   if(f.equals("LEFTKNEE")) out = SimpleOpenNI.SKEL_LEFT_KNEE;
   if(f.equals("RIGHTKNEE")) out = SimpleOpenNI.SKEL_RIGHT_KNEE;
   if(f.equals("LEFTFOOT")) out = SimpleOpenNI.SKEL_LEFT_FOOT;
   if(f.equals("RIGHTFOOT")) out = SimpleOpenNI.SKEL_RIGHT_FOOT;
   return(out);


}

