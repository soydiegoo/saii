import urllib3
import serial
import json
arduino = serial.Serial('COM4', baudrate = 9600, timeout = 0.3)
#arduino.flushInput()

while True:
    row = arduino.readline();
    if row:
        line = row.decode('utf-8')
        line2 = line.bytedecode
        test = str(line)
        usuario = {
            "lectura":test
        }
        http = urllib3.PoolManager() #SE CONFIGURA UN REQUEST PARA CREAR UN SERVICIO
        URL = 'http://localhost/SAII_php/api_2.php' #USO DE SERVICIO LOCAL
        response = http.request('POST', URL, fields=usuario) #CONEXION AL SERVICIO
        jsonData = response.data.decode("UTF-8")  #LEE LOS CARACTERES
        print (line)
        print(jsonData)
        print(usuario)
        # data = json.loads(jsonData) #LEE CARACTERES
        # x =  data["success"]
        # print (data)
        # # arduino.write(bytes(x,'utf-8'))