from BeautifulSoup import BeautifulSoup
import json
import sys

m2 = json.loads(open("toc2.json").read())
soup = BeautifulSoup(open(sys.argv[1]).read())
for h1 in soup.findAll('h1'):
    for key in m2:
        if h1.text in key:
            span = h1.find('span')
            if span is not None:
                span.string = key

open(sys.argv[1], 'wb').write(str(soup))