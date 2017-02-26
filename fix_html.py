import sys
from BeautifulSoup import BeautifulSoup

if sys.argv[2] == "true":
  rel = "../"
else:
  rel = ""
soup = BeautifulSoup(open(sys.argv[1]).read())
for a in soup.findAll('a'):
  if a.get('href').endswith('/'):
    a['href'] = a['href'] + 'index.html'
  if a.get('href').startswith('/'):
    a['href'] = rel + a['href'][1:]

for img in soup.findAll('img'):
  if img.get('src').startswith('/'):
    img['src'] = rel + img['src'][1:]

content = str(soup).replace("ZZ/", rel).replace("url(/ima", "url(" + rel + "ima")
open(sys.argv[1], 'wb').write(content)