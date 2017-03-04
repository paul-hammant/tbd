from bs4 import BeautifulSoup
import sys
import json

soup = BeautifulSoup(open(sys.argv[1]).read(), "html.parser")

# Refs for Footer

ftr = 0
refs = "<p>"
for span in soup.find_all("span", { "class" : "rref" }):
  ftr += 1;
  try:
    refs += str(ftr) + ": " + span.a['href'] + "<br/>"
  except TypeError:
    print str(span)
    raise
  new_tag = soup.new_tag('sup')
  new_tag.string = "[" + str(ftr) + "]"
  span.a.replace_with(new_tag)
refs += "</p>"

h2 = soup.find("h2", { "id" : "references-elsewhere" })
if h2 is not None:
  ix = h2.parent.contents.index(h2)
  h2.parent.insert(ix, BeautifulSoup(refs, "html.parser"))

for a in soup.find_all("a"):
  href = a['href'].replace('../','')
  if ":" not in href:
    if "#" not in href:
      sub_chapters = json.loads(open(href.replace(".html", ".json")).read())
      a.replace_with(BeautifulSoup("<span><i>"+a.text+"</i><sup>[ch: "+sub_chapters['ch']+"]</sup></span>", "html.parser"))
    else:
      file = href.replace(".html", ".json")
      file = file[0:file.index("#")]
      subchap = href[href.index("#")+1:]
      sub_chapters = json.loads(open(file).read())
      xx = sub_chapters['h2s']
      try:
        a.replace_with(BeautifulSoup("<span><i>"+a.text+"</i><sup>[ch: "+xx[subchap]+"]</sup></span>", "html.parser"))
      except KeyError:
        print str(a)
        raise


open(sys.argv[1], 'wb').write(str(soup))
