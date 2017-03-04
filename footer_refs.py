from bs4 import BeautifulSoup
import sys

soup = BeautifulSoup(open(sys.argv[1]).read(), "html.parser")
ftr = 0
refs = "<p>"
for span in soup.find_all("span", { "class" : "rref" }):
  ftr += 1;
  refs += str(ftr) + ": " + span.a['href'] + "<br/>"
  new_tag = soup.new_tag('sup')
  new_tag.string = "[" + str(ftr) + "]"
  span.a.replace_with(new_tag)
refs += "</p>"

h2 = soup.find("h2", { "id" : "references-elsewhere" })
#new_tag = soup.new_tag('p')
#print refs
#new_tag.string = BeautifulSoup(refs, "html.parser")
ix = h2.parent.contents.index(h2)
h2.parent.insert(ix, BeautifulSoup(refs, "html.parser"))

open(sys.argv[1], 'wb').write(str(soup))
