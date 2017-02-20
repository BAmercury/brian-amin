#!/usr/bin/env python

import cv2
import time
#import MotorControl as mc




def initCam():
    port = int(raw_input("Camera Port: "))
    cam = cv2.VideoCapture('WIN_20170116_16_17_18_Pro.mp4')
    #cam.release()
    #cam.open(port)
    time.sleep(5)



def processframe():
    retval, frame = cam.retrieve()
    #frame = cv2.imread('img.png')
    
    #frame = cv2.resize(frame,None,fx=0.5, fy=0.5, interpolation = cv2.INTER_AREA)
    detect = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
    upper = cv2.CascadeClassifier('haarcascade_frontalface_alt2.xml')
	#comments
    frontal = detect.detectMultiScale(frame,scaleFactor=1.3, minNeighbors=5, minSize=(30, 30), flags=cv2.CASCADE_SCALE_IMAGE)
    #Eventually will download and implement profile classifier
    profile = upper.detectMultiScale(frame,scaleFactor=1.3, minNeighbors=5, minSize=(30, 30), flags=cv2.CASCADE_SCALE_IMAGE)
    
	
    for (x,y,w,h) in frontal:
		cv2.rectangle(frame, (x, y), (x+w, y+h), (0,0,153), 5)	
		cv2.circle(frame, ( x,y  ),10,(0,153,0))
		center = ( (x+(w/2)))
		print(center)
		if (center < 320 and center > 160 ):
			print("Frame is in the center of frame")
			motorstop = 1
			print("Firing Main Cannon")

    for (x,y,w,h) in profile:
        cv2.rectangle(frame, (x,y), (x+w, y+h), (0,0,170), 5)



    cv2.imshow("w", frame)


        

	

#port = int(raw_input("Camera Port: "))
#cam = cv2.VideoCapture(0)
#cam.release()
#cam.open(port)
#time.sleep(5)

while True:
	processframe()
	if cv2.waitKey(50) & 0xFF == ord('z'):
		break
cam.release()
cv2.DestoryAllWindows()

