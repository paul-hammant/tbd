from BeautifulSoup import BeautifulSoup
import json
import sys

toc2 = json.loads(open("toc2.json").read())
soup = BeautifulSoup(open(sys.argv[1]).read())
ch = 0

ch_breakdown = {}
ch_breakdown['h2s'] = {}

for h1 in soup.findAll('h1'):
    for key, ix in toc2.items():
        if h1.text in key:
            span = h1.find('span')
            if span is not None:
                span.string = key
                ch = ix;

h2_ix = 0
for h2 in soup.findAll('h2'):
  if 'references-elsewhere' not in h2['id']:
    h2_ix += 1
    ch_breakdown['h2s'][h2['id']] = str(ch) + "." + str(h2_ix)
ch_breakdown["ch"] = str(ch)

for footer in soup.findAll('footer'):
  footer.replaceWith('')
for aside in soup.findAll('aside'):
  aside.replaceWith('')

open(sys.argv[1].replace(".html",".json"), 'wb').write(json.dumps(ch_breakdown))
open(sys.argv[1], 'wb').write(str(soup))