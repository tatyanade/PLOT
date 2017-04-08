// see https://processing.org/reference/libraries/pdf/index.html
import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 0; 


int canvasOffset = 10;

int faceWidthAvg = 80;
int faceHeightAvg = 130;
int faceWidthLimit = 160;
int faceHeightLimit = 180;



//var facepoints = 0
int faceHeight = 0;
int faceWidth = 0;
int chinHeight = 0;

int topy = 0;
int chiny = 0;
int topRighty = 0;
int topLefty = 0;
int bottomRighty = 0;
int bottomLefty = 0;

int topx = 0;
int chinx = 0;
int topRightx = 0;
int topLeftx = 0;
int bottomRightx = 0;
int bottomLeftx = 0;

int foreheadHeight = 0;

int numberFacePoints = 0;



int bezier1x = 0;
int bezier1y = 0;
int bezier2x = 0;
int bezier2y = 0;
int bezier3x = 0;
int bezier3y = 0;
int bezier4x = 0;
int bezier4y = 0;
int bezier5x = 0;
int bezier5y = 0;
int bezier6x = 0;
int bezier6y = 0;
int bezier7x = 0;
int bezier7y = 0;
int bezier8x = 0;
int bezier8y = 0;
int bezier9x = 0;
int bezier9y = 0;
int bezier10x = 0;
int bezier10y = 0;

int chinAngle = 0;
int bottomAngle = 0;
int topSideAngle = 0;
int topAngle = 0;

int chinAngleLength = 0;
int bottomAngleLength = 0;
int topSideAngleLength = 0;
int topAngleLength = 0;


int eyeDistAvg = 90;
int eyeLengthAvg = 30;
int eyeHeightAvg = 18;
int eyeDist = 0;
int eyeCenter1 = 0;
int eyeCenter2 = 0;
int eyeCenterY = 0;

int diameter = 0;
int eyeAngle = 0;

int eyelid1x1 = 0;
int eyelid1y1 = 0;
int eyelid1x2 = 0;
int eyelid1y2 = 0;
int eyelid2x1 = 0;
int eyelid2y1 = 0;
int eyelid2x2 = 0;
int eyelid2y2 = 0;

int eyeWidth = 0;

int noseType = 0;
int noseCenterx = 0;
int noseCenterx2 = 0;
int noseCentery = 0;


void setup() 
{
  //faceWidthLimit + canvasOffset = 10+160 = 170
  //faceHeightLimit + canvasOffset = 10+200 = 210
  size(170, 210);
  background(123,123,132);
  bRecordingPDF = true;
}
 
void keyPressed() {
  // When you press a key, it will initiate a PDF export
  bRecordingPDF = true;
}
 
void draw() 
{
  if (bRecordingPDF) 
  {
    background(255); // this should come BEFORE beginRecord()
    beginRecord(PDF, "face_" + pdfOutputCount + ".pdf");
    getFacePoints();
    getBezier();
    getEyes();
    getNose();
    getMouth();
    //--------------------------
    
    
    
    drawFacePoints();
    drawEyes();
    drawNose();
    drawMouth();
    
    
    
    
    //--------------------------
 
    endRecord();
    bRecordingPDF = false;
    pdfOutputCount++;
  }
}

int mouthx = 0;
int mouthy = 0;

void getMouth()
{

  mouthx = round(random(20,faceWidth));
  mouthy = round(random(100,150));


}

void drawMouth()
{
  beginShape();
  curveVertex(mouthx,mouthy);
  curveVertex(mouthx+round(random(0,12)),mouthy+round(random(0,12)));
  curveVertex(mouthx-round(random(-12,34)),mouthy-round(random(-12,12)));
  curveVertex(mouthx,mouthy);
  endShape(CLOSE);

}

void getNose()
{
  noseType = round(random(0,2));
  if (noseType == 1)
  {
    noseCentery = round(random(50,faceHeight));
    noseCenterx = width/2 - round(random(0,6));
    noseCenterx2 = width/2 + round(random(0,6));
  }
  else
  {
    noseCentery = faceHeight/2 + round(random(-10,10)); 

  }

}
void drawNose()
{
  if (noseType == 1)
  {
    ellipse(noseCenterx,noseCentery + round(random(-3,3)), round(random(5,5)), round(random(5,5)));
    ellipse(noseCentery,noseCentery + round(random(-3,3)), round(random(5,5)), round(random(5,5)));
  }
  else
  {
    triangle(noseCenterx + round(random(-4,4)), noseCentery+round(random(-2,2)),
             noseCenterx + round(random(-8,-4)),noseCentery+round(random(2,6)),
             noseCenterx + round(random(4,8)), noseCentery +round(random(2,6)));
  }

}

void drawEyes()
{
  ellipse(eyeCenter2,eyeCenterY,diameter,diameter);
  ellipse(eyeCenter1,eyeCenterY,diameter,diameter);
  
  ellipse(eyeCenter2,eyeCenterY,diameter-3,diameter-3);
  ellipse(eyeCenter1,eyeCenterY,diameter-3,diameter-3);

  if (random(40)>30)
  {
    ellipse(eyeCenter2,eyeCenterY,2,2);
    ellipse(eyeCenter1,eyeCenterY,2,2);
  }
  //stroke(15,15,15);


  beginShape();
  curveVertex(eyelid1x1,eyelid1y1);
  curveVertex(eyelid1x2,eyelid1y2);
  curveVertex(eyelid1x2+round(random(-2,2)),eyelid1y2+round(random(-2,2)));
  curveVertex(eyelid1x1,eyelid1y1);
  endShape(CLOSE);

  beginShape();
  curveVertex(eyelid2x1,eyelid2y1);
  curveVertex(eyelid2x1+round(random(-2,2)),eyelid2y1+round(random(-2,2)));
  curveVertex(eyelid2x2,eyelid2y2);
  curveVertex(eyelid2x1,eyelid2y1);
  endShape(CLOSE);

}

void getEyes()
{

eyeDist = round(random((eyeDistAvg-30),(eyeDistAvg+20)));
eyeCenterY = round(random((foreheadHeight-10),(foreheadHeight+40)));
eyeCenter1 = width/2 - eyeDistAvg/2;
eyeCenter2 = width/2 + eyeDistAvg/2;
diameter = round(random(2,20));
eyeAngle = round(random(-45,45));
eyeWidth = round(random(eyeLengthAvg-10,eyeLengthAvg+10));

eyelid1x1 = getEndpointsX(eyeCenter1,eyeCenterY,eyeAngle,eyeWidth);
eyelid1y1 = getEndpointsY(eyeCenter1,eyeCenterY,eyeAngle,eyeWidth);
eyelid1x2 = getEndpointsX(eyeCenter1,eyeCenterY,eyeAngle-180,eyeWidth);
eyelid1y2 = getEndpointsY(eyeCenter1,eyeCenterY,eyeAngle-180,eyeWidth); 

eyelid1x1 = getEndpointsX(eyeCenter1,eyeCenterY,360-eyeAngle,eyeWidth);
eyelid1y1 = getEndpointsY(eyeCenter1,eyeCenterY,360-eyeAngle,eyeWidth);
eyelid1x2 = getEndpointsX(eyeCenter1,eyeCenterY,360-eyeAngle-180,eyeWidth);
eyelid1y2 = getEndpointsY(eyeCenter1,eyeCenterY,360-eyeAngle-180,eyeWidth); 
}




void drawFacePoints()
{
 //numberFacePoints = 5;   //GETTING RID OF 4 POINTS BECAUSE BEZIER DIDNT WORK
 if (numberFacePoints == 4)
 {
 
    beginShape();
    curveVertex(bezier1x,bezier1y);
    curveVertex(bezier2x,bezier2y+round(random(-10,10)));
    curveVertex(bezier3x,bezier3y);
    curveVertex(bezier4x+round(random(-10,10)),bezier4y);
    curveVertex(bezier5x+round(random(-10,10)),bezier5y);
    curveVertex(bezier6x,bezier6y);
    curveVertex(bezier7x,bezier7y+round(random(-10,10)));
    curveVertex(bezier8x+round(random(-10,10)),bezier8y); 
    
    
    
    endShape(CLOSE);
  

 }
  else
  {

    beginShape();
    curveVertex(topRightx,topRighty+round(random(-20,90)));
    curveVertex(topLeftx+round(random(-10,10)),topLefty);
    curveVertex(bottomLeftx+round(random(-40,10)),bottomLefty);
    curveVertex(chinx,chiny+round(random(-10,30)));
    curveVertex(bottomRightx,bottomRighty);
    curveVertex(topRightx+round(random(-10,10)),topRighty);
    curveVertex(topLeftx,topLefty+round(random(-10,10)));
    curveVertex(bottomLeftx,bottomLefty);
  
    endShape(CLOSE);

  }
}


void getBezier()
{

  chinAngle = 0;
  chinAngleLength = round(random(0,30));

  if (numberFacePoints == 4)
  {
    topAngle = 0;
    topAngleLength = round(random(0,30));

    bezier1x = topx - topAngleLength; //getEndpointsX(topx, topy, topAngleLength, 180);
    bezier1y = topy; //getEndpointsY(topx, topy, topAngleLength, 180);
    bezier2x = topx + topAngleLength; //getEndpointsX(topx, topy, topAngleLength, 0);
    bezier2y = topy; //getEndpointsY(topx, topy, topAngleLength, 0);

    bottomAngleLength = round(random(0,30));
    bottomAngle = round(random(20,90));

    int tempLength = round(random(0,50));

    bezier3x = bottomLeftx;
    bezier3y = bottomLefty - bottomAngleLength - tempLength;

    bezier4x = bottomLeftx;
    bezier4y = bottomLefty + bottomAngleLength;

    chinAngle = 0;
    chinAngleLength = round(random(0,30));

    bezier5x = chinx - chinAngleLength;
    bezier5y = chiny;

    bezier6x = chinx + chinAngleLength;
    bezier6y = chiny;

    bezier7x = bottomRightx;
    bezier7y = bottomRighty + bottomAngleLength;

    bezier8x = bottomRightx;
    bezier8y = bottomRighty - bottomAngleLength - tempLength;


  }
  else
  {
    topSideAngle = round(random(45,90));
    topSideAngle = round(random(0,30));

    bezier1x = getEndpointsX(topRightx,topRighty, topAngleLength, 180-topSideAngle);
    bezier1y = getEndpointsY(topRightx,topRighty, topAngleLength, 180-topSideAngle);

    bezier2x = getEndpointsX(topRightx,topRighty, topAngleLength, 180-topSideAngle+180);
    bezier2y = getEndpointsY(topRightx,topRighty, topAngleLength, 180-topSideAngle+180);

    bezier10x = getEndpointsX(topLeftx,topLefty, topAngleLength, topSideAngle);
    bezier10y = getEndpointsY(topLeftx,topLefty, topAngleLength, topSideAngle);

    bezier9x = getEndpointsX(topLeftx,topLefty, topAngleLength, topSideAngle+180);
    bezier9y = getEndpointsY(topLeftx,topLefty, topAngleLength, topSideAngle+180);



    chinAngle = 0;
    chinAngleLength = round(random(0,30));

    bezier5x = chinx - chinAngleLength;
    bezier5y = chiny;

    bezier6x = chinx + chinAngleLength;
    bezier6y = chiny;


    bottomAngle = round(random(90,135));
    bottomAngleLength = round(random(0,30));


    bezier3x = getEndpointsX(bottomLeftx,bottomLefty, bottomAngleLength, bottomAngle);
    bezier3y = getEndpointsY(bottomLeftx,bottomLefty, bottomAngleLength, bottomAngle);

    bezier4x = getEndpointsX(bottomLeftx,bottomLefty, bottomAngleLength, bottomAngle+180);
    bezier4y = getEndpointsY(bottomLeftx,bottomLefty, bottomAngleLength, bottomAngle+180);


    bezier7x = getEndpointsX(bottomLeftx,bottomLefty, bottomAngleLength, 180-bottomAngle);
    bezier7y = getEndpointsY(bottomLeftx,bottomLefty, bottomAngleLength, 180-bottomAngle);

    bezier8x = getEndpointsX(bottomLeftx,bottomLefty, bottomAngleLength, 180-bottomAngle+180);
    bezier8y = getEndpointsY(bottomLeftx,bottomLefty, bottomAngleLength, 180-bottomAngle+180);
  }




}





void getFacePoints()
//determines the faces shape
{
  getFaceWidth();
  getFaceHeight();
  chinHeight = round(faceHeight * ( random(30,50)*.01));
  foreheadHeight = round(faceHeight * ( random(50,60)*.01));
  
  
  if (round(random(4,6)) == 5)  
  //the face has 4 points
  {

    if (random(3)>2)
      //so that top and bottom arent always same length
    {
      getFaceWidth();
    }
    
    topx = width/2;
    topy = (faceHeightAvg - faceHeight)/2 + canvasOffset;
    chinx = width/2 ;
    chiny = faceHeightLimit - topy;
    bottomLeftx = (width/2) + (faceWidth/2); 
    bottomLefty = chiny-chinHeight ;
    bottomRightx = (width/2) - (faceWidth/2);
    bottomRighty = bottomLefty ;
    topLeftx = (width/2) + (faceWidth/2);
    topLefty = //chiny-foreheadHeight ;
    topRightx = (width/2) - (faceWidth/2);
    topRighty = topLefty; //chiny-foreheadHeight ;

    numberFacePoints = 5;

  }
  else
  {
    topx = width/2;
    topy = (faceHeightAvg - faceHeight)/2 + canvasOffset;
    chinx = width/2;
    chiny = faceHeightLimit - topy;
    bottomRightx = (width/2) + faceWidth/2 ;
    bottomRighty = chiny-chinHeight;
    bottomLeftx = width/2 - faceWidth/2;
    bottomLefty = bottomRighty;

    numberFacePoints = 4;

  }

}

void getFaceWidth()
{
  faceWidth = round(faceWidthAvg + random((faceWidthLimit-faceWidthAvg)/2));
  if (random(2)==1) 
  { 
    faceWidth = round(faceWidthAvg  -  random((faceWidthLimit-faceWidthAvg)/2)); 
  }
}
void getFaceHeight()
{
  faceHeight = round(faceHeightAvg + random((faceHeightLimit-faceHeightAvg)/2));
  if (random(2)==1) 
  { 
  faceHeight = round(faceHeightAvg  -  random((faceHeightLimit-faceHeightAvg)/2)); 
  }
}













int getEndpointsX(int x, int y,int angle,int length)
//http://stackoverflow.com/questions/1638437/given-an-angle-and-length-how-do-i-calculate-the-coordinates
{
  y = y + 0;
  return(round( x + length*cos(radians(angle))));
}

int getEndpointsY(int x,int y,int angle, int length)
//http://stackoverflow.com/questions/1638437/given-an-angle-and-length-how-do-i-calculate-the-coordinates
{
  x = x + 0;
  return (round((  y + length*sin(radians(angle)))));
}
