from BeautifulSoup import BeautifulSoup
import json
import sys

m2 = json.loads(open("toc2.json").read())
soup = BeautifulSoup(open(sys.argv[1]).read())
for h1 in soup.findAll('h1'):
    print ">>>> " + h1.text
    for key in m2:
        if h1.text in key:
            h1.find('span').string = key

open(sys.argv[1], 'wb').write(str(soup))