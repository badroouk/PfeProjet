import statistics
from urllib import response
import mysql.connector
from flask import Flask, jsonify, request
import json

db = mysql.connector.connect(host='192.168.56.1',username="badr",passwd="password",port=3306,database="iot")

mycursor = db.cursor()


app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def hello():
    global response
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        value = request_data['value']
        dateStart = request_data['date_start']
        dateEnd = request_data['date_end']

        mycursor.execute('SELECT '+ str(value) +' FROM `arduino`WHERE arduino.created_at BETWEEN ' +"\""+str(dateStart) +"\""+ ' AND ' +"\""+ str(dateEnd) +"\""+';')

        row = [item[0] for item in mycursor.fetchall()]

        cursormean = statistics.mean(row)
        cursormedian = statistics.median(row)
        cursorvariance = statistics.variance(row)
        cursormode = statistics.mode(row)


        response = jsonify({'cursormean': cursormean, 'cursormed':cursormedian,'cursorvar':cursorvariance,'cursormode':cursormode })
    return response
