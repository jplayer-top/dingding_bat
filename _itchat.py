import requests
header_dict = {'User-Agent':'Mozilla/5.0 (Linux; Android 8.0; MHA-AL00 Build/HUAWEIMHA-AL00; wv)'}
res = requests.post('https://www.wkcq365.com/api/share/sendCode', data = {'mobile':'17667936541'},headers=header_dict)
print(res.text)
