from BeautifulSoup import BeautifulSoup
import json

soup = BeautifulSoup(open("toc.html").read())
ch = 0
m = {}
m2 = {}
for a in soup.findAll('a'):
  if 'index.html' in a.get('href'):
    ch += 1
    a.string = str(ch) + ". " + a.text
    m[a.get('href').replace("/index.html", "")] = ch
    m2[a.text] = ch

open("toc.json", 'wb').write(json.dumps(m))
open("toc2.json", 'wb').write(json.dumps(m2))

open("toc.html", 'wb').write(str(soup))