import serial
arduino = serial.Serial('COM3', baudrate = 9600, timeout=0.3)

while True:
    row = arduino.readline()
    line=row.decode()
    print(line)

    