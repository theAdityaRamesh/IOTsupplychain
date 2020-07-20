import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle

app = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))

config = {
    "apiKey": "AIzaSyCz88gMEllc0vbJxYrTRxWmQwaTDGJhsQY",
    "authDomain": "supplychainiot-3daf3.firebaseapp.com",
    "databaseURL": "https://supplychainiot-3daf3.firebaseio.com",
    "projectId": "supplychainiot-3daf3",
    "storageBucket": "supplychainiot-3daf3.appspot.com",
    "messagingSenderId": "294363553321",
    "appId": "1:294363553321:web:c094d0a8859045858b0638",
    "serviceAccount":"E:\\Deployment-flask-master\\env\\supplychainiot-3daf3-firebase-adminsdk-cr7ih-351ba4d46b.json"
}

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use a service account
cred = credentials.Certificate("E:\\Deployment-flask-master\\env\\supplychainiot-3daf3-firebase-adminsdk-cr7ih-351ba4d46b.json")
firebase_admin.initialize_app(cred)

db = firestore.client()


@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict',methods=['POST'])
def predict():
    '''
    For rendering results on HTML GUI
    '''
    features = [float(x) for x in request.form.values()]
    features = [np.array(features)]
    output = model.predict(features)

    data = {"ols":request.form["OLS"],"qos":request.form["QOS"],"me":request.form["ME"],"pa":request.form["OLS"],"pred":str(output[0])}
    doc_ref = db.collection('prediction').document('val')
    doc_ref.set(data)
    
    return render_template('index.html', prediction_text='Logistics Supplier Score is :  {}'.format(output))

@app.route('/predict_api',methods=['POST'])
def predict_api():
    '''
    For direct API calls trought request
    '''
    data = request.get_json(force=True)
    prediction = model.predict([np.array(list(data.values()))])

    output = prediction[0]
    return jsonify(output)

if __name__ == "__main__":
    app.run(debug=True)