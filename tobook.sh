#!/bin/sh

function normalize_index_file_names {
    python ../fix_html.py "$1" "$2"
}

function convert_to_book {
  ebook-convert toc.html "../book/trunk_based_development_book$1" --page-breaks-before "//h:h1" --chapter "//h1" \
  --breadth-first "$2" "$3" --publisher=trunkbaseddevelopment.com --language=en --title "Trunk Based Development" \
  --authors "Paul Hammant & Steve Smith" --pubdate "$PBDT" --cover ../book_cover.jpg
}

function extract_just_the_article {

  # arg 1 directory for index.html file (or "" for root)
  # arg 2 true if sub directory

  cat ../book_page_start.html > "$1index.html2"
  xidel --html "$1index.html" --extract "//article" | sed '/<!DOCTYPE html>/d' >> "$1index.html2"
  echo "</body></html>" >> "$1index.html2"
  mv "$1index.html2" "$1index.html"

  cat "$1index.html" \
    | sed 's/<aside/<aside style="display: none"/' \
    | sed 's#<h1 id="references-elsewhere">References elsewhere</h1>#<h2 id="references-elsewhere">References elsewhere</h2>#' \
    | sed 's/<footer/<footer style="display: none"/' \
    | sed 's/<nav/<nav style="display: none"/' \
    | sed 's/References elsewhere/References on the web/' \
    | sed 's/his site/his book/' \
    | sed '/showHideRefs/d' \
    | sed '/headerlink/d' \
    | awk 'NF' \
    | sponge "$1index.html"

  # change videos to links to videos, and remove sections not for print
  cat "$1index.html" | sed '/ noprint/d' \
    | sed 's/<!-- print //' \
    | sed 's/ print -->//' | sponge "$1index.html"

  python ../toc_number_applier.py "$1index.html"

}

function normalize_index_file_names_and_extract_just_the_article {
  extract_just_the_article $1 $2
  normalize_index_file_names "$1index.html" $2
}

set -e

# Gen site to temp folder
hugo --disableRSS --quiet -d tempHugo

cd tempHugo

# Table of contents gets inserted once (was on every page)
GIT_DATE=$(git log | head -n 3 | grep Date | tr -s ' ' | cut -d ' ' -f2-12)
echo "<html><body><h1>Table of Contents</h1>$(xidel --html index.html --extract "//div[@class='drawer']")<br/>Book transformation of \
<a href='https://trunkbaseddevelopment.com'>TrunkBasedDevelopment.com</a><br/>Copyright &copy; 2017: Paul Hammant \
and Steve Smith<br/>This book is free (gratis) to copy as long as you don't modify it, otherwise your owe \
us \$1,000,000 USD<br/>Generated $GIT_DATE <br/></body></html>" \
  | sed 's/<!DOCTYPE html>//' \
  | awk 'NF' \
  | sed '/<strong>Trunk Based Development/d' \
  | sed 's/Site Source/Book Source/' \
  | sed 's/<aside/<aside style="display: none"/' \
  | sed "s#href=\"/#href=\"#g" \
  | sed "s#title=\"Introduction\" href=\"\"#title=\"Introduction\" href=\"index.html\"#" \
  | sed "s#src=\"/#src=\"#g" > toc.html
normalize_index_file_names toc.html false

python ../toc_numberer.py

# slim site down to content
normalize_index_file_names_and_extract_just_the_article 5-min-overview/ true
normalize_index_file_names_and_extract_just_the_article alternative-branching-models/ true
normalize_index_file_names_and_extract_just_the_article branch-by-abstraction/ true
normalize_index_file_names_and_extract_just_the_article branch-for-release/ true
normalize_index_file_names_and_extract_just_the_article concurrent-development-of-consecutive-releases/ true
normalize_index_file_names_and_extract_just_the_article context/ true
normalize_index_file_names_and_extract_just_the_article continuous-delivery/ true
normalize_index_file_names_and_extract_just_the_article continuous-integration/ true
normalize_index_file_names_and_extract_just_the_article continuous-review/ true
normalize_index_file_names_and_extract_just_the_article deciding-factors/ true
normalize_index_file_names_and_extract_just_the_article expanding-contracting-monorepos/ true
normalize_index_file_names_and_extract_just_the_article feature-flags/ true
normalize_index_file_names_and_extract_just_the_article game-changers/ true
normalize_index_file_names_and_extract_just_the_article monorepos/ true
normalize_index_file_names_and_extract_just_the_article observed-habits/ true
normalize_index_file_names_and_extract_just_the_article publications/ true
normalize_index_file_names_and_extract_just_the_article release-from-trunk/ true
normalize_index_file_names_and_extract_just_the_article strangulation/ true
normalize_index_file_names_and_extract_just_the_article vcs-features/ true
normalize_index_file_names_and_extract_just_the_article vcs-choices/ true
normalize_index_file_names_and_extract_just_the_article youre-doing-it-wrong/ true
normalize_index_file_names_and_extract_just_the_article book/ true

# slim the front page too.
normalize_index_file_names_and_extract_just_the_article './' false
cat index.html | sed '/<h1>Introduction/d' | sponge index.html

# stitch into PDF book
mkdir -p ../book

wget -O gfonts.css "https://fonts.googleapis.com/css?family=Ubuntu:400,700|Ubuntu+Mono"

perl -pi -e 's/.query:-moz-placeholder,//' stylesheets/application.css
perl -pi -e 's/.query:-ms-input-placeholder//' stylesheets/application.css
#convert_to_book .pdf --base-font-size 6
git init
git add .
git commit -m "start"
perl -pi -e 's/background-color:/font-size: 73%; background-color:/' vcs-features/index.html
perl -pi -e 's/background-color:/font-size: 73%; background-color:/' vcs-choices/index.html
perl -pi -e 's/background-color:/font-size: 75%; background-color:/' continuous-integration/index.html
perl -pi -e 's/background-color:/font-size: 80%; background-color:/' continuous-review/index.html
perl -pi -e 's/background-color:/font-size: 80%; background-color:/' continuous-delivery/index.html
perl -pi -e 's/background-color:/font-size: 48%; background-color:/' concurrent-development-of-consecutive-releases/index.html
perl -pi -e 's/background-color:/font-size: 87%; background-color:/' strangulation/index.html
perl -pi -e 's/background-color:/font-size: 75%; background-color:/' alternative-branching-models/index.html
perl -pi -e 's/background-color:/font-size: 62%; background-color:/' expanding-contracting-monorepos/index.html
#convert_to_book .mobi --pretty-print --pretty-print
#convert_to_book .epub --pretty-print --pretty-print
git stash

python ../footer_refs.py 5-min-overview/index.html 
python ../footer_refs.py alternative-branching-models/index.html 
python ../footer_refs.py branch-by-abstraction/index.html 
python ../footer_refs.py branch-for-release/index.html 
python ../footer_refs.py concurrent-development-of-consecutive-releases/index.html 
python ../footer_refs.py context/index.html 
python ../footer_refs.py continuous-delivery/index.html 
python ../footer_refs.py continuous-integration/index.html 
python ../footer_refs.py continuous-review/index.html 
python ../footer_refs.py deciding-factors/index.html 
python ../footer_refs.py expanding-contracting-monorepos/index.html 
python ../footer_refs.py feature-flags/index.html 
python ../footer_refs.py game-changers/index.html 
python ../footer_refs.py monorepos/index.html
python ../footer_refs.py observed-habits/index.html 
python ../footer_refs.py publications/index.html 
python ../footer_refs.py release-from-trunk/index.html 
python ../footer_refs.py strangulation/index.html 
python ../footer_refs.py vcs-features/index.html 
python ../footer_refs.py vcs-choices/index.html 
python ../footer_refs.py youre-doing-it-wrong/index.html 
python ../footer_refs.py book/index.html 

convert_to_book _printable.pdf --base-font-size 6
rm -rf .git
cd ../book/
#netlify deploy
cd ..
#rm -rf tempHugo/