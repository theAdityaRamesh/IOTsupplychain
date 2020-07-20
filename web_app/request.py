import requests

url = 'http://localhost:5000/predict_api'
r = requests.post(url,json={'objective_logistics_capacity':0.7,'quality_of_service':0.865,'management_effectiveness':0.95,'price_advantage':0.8})

print(r.text)