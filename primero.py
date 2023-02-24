import urllib3
http = urllib3.PoolManager()
r = http.request('GET', 'https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp')
r.status
r.data
print(r.data)
print(r.status)

