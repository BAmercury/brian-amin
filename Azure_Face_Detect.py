import cognitive_face as CF

KEY = ('c34881b3c80745a4b7a06c8047cd66f4' + ','+ 'https://westcentralus.api.cognitive.microsoft.com/face/v1.0')  # Replace with a valid subscription key (keeping the quotes in place).
CF.Key.set(KEY)


# You can use this example JPG or replace the URL below with your own URL to a JPEG image.
img_url = 'C:\Users\Merc.MERCURY\Desktop\active\img.jpg'
result = CF.face.detect(img_url)
print result