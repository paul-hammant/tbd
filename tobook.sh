#!/bin/sh

function normalize_index_file_names {
  grep -rl "$1" . | xargs sed -i '' "s#$1\"#$1index.html\"#g"
}

function convert_to_book {
  ebook-convert toc.html "../book/trunk_based_development_book.$1" --page-breaks-before "//h:h1" --chapter "//h1" \
  --breadth-first --publisher=trunkbaseddevelopment.com --language=es --title "Trunk Based Development" \
  --authors "Paul Hammant & Steve Smith" --pubdate "$PBDT" --cover ../book_cover.jpg
}

function extract_just_the_article {

  # arg 1 directory for index.html file (or "" for root)
  # arg 2 true if sub directory

  echo "<html><head></head><body>" > "$1index.html2"
  xidel --html "$1index.html" --extract "//article" | sed '/<!DOCTYPE html>/d' >> "$1index.html2"
  echo "</body></html>" >> "$1index.html2"
  mv "$1index.html2" "$1index.html"

  cat "$1index.html" | sed 's/<!DOCTYPE html>//' \
    | sed 's/<aside/<aside style="display: none"/' \
    | sed 's#<h1 id="references-elsewhere">References elsewhere</h1>#<h2 id="references-elsewhere">References elsewhere</h2>#' \
    | sed 's/<footer/<footer style="display: none"/' \
    | sed 's/<nav/<nav style="display: none"/' \
    | sed 's/References elsewhere/References on the web/' \
    | sed 's/his site/his book/' \
    | sed 's/his portal/his book/' \
    | sed '/showHideRefs/d' \
    | sed '/^[ \t]*$/d' \
    | sponge "$1index.html"

  # change videos to links to videos, and remove sections not for print
  cat "$1index.html" | sed '/ noprint/d' \
    | sed 's/<!-- print //' \
    | sed 's/ print -->//' | sponge "$1index.html"

  if [ "$2" = true ] ; then
    cat "$1index.html" | sed "s#href=\"/#href=\"../#g" \
      | sed "s#src=\"/#src=\"../#g" \
      | sed "s#url(/images/LogoSlim#url(../images/LogoSlim#g" | sponge "$1index.html"
  else
    cat "$1index.html" | sed "s#href=\"/#href=\"#g" \
      | sed "s#src=\"/#src=\"#g" \
      | sed "s#url(/images/LogoSlim#url(images/LogoSlim#g" | sponge "$1index.html"
  fi
}

function normalize_index_file_names_and_extract_just_the_article {
  if [ "$2" = true ] ; then
    normalize_index_file_names $1
  fi
  extract_just_the_article $1 $2
}

# Gen site to temp folder
hugo --disableRSS --quiet -d tempHugo

cd tempHugo

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
normalize_index_file_names_and_extract_just_the_article monorepos/ true
normalize_index_file_names_and_extract_just_the_article observed-habits/ true
normalize_index_file_names_and_extract_just_the_article publications/ true
normalize_index_file_names_and_extract_just_the_article release-from-trunk/ true
normalize_index_file_names_and_extract_just_the_article strangulation/ true
normalize_index_file_names_and_extract_just_the_article vcs-features/ true
normalize_index_file_names_and_extract_just_the_article vcs-choices/ true
normalize_index_file_names_and_extract_just_the_article youre-doing-it-wrong/ true

# Table of contents gets inserted once (was on every page)
PBDT=$(git log | head -n 3 | grep Date | tr -s ' ' | cut -d ' ' -f2-12)
echo "<html><body><h1>Table of Contents</h1>$(xidel --html index.html --extract "//div[@class='drawer']")<br/>Book transformation of \
<a href='https://trunkbaseddevelopment.com'>TrunkBasedDevelopment.com</a><br/>Copyright &copy; 2017: Paul Hammant \
and Steve Smith<br/>This book is free (gratis) to copy as long as you don't modify it, otherwise your owe \
us \$1,000,000 USD<br/>Generated $PBDT <br/></body></html>" \
  | sed 's/<!DOCTYPE html>//' \
  | sed '/^[ \t]*$/d' \
  | sed '/<strong>Trunk Based Development/d' \
  | sed 's/Site Source/Book Source/' \
  | sed 's/<aside/<aside style="display: none"/' \
  | sed "s#href=\"/#href=\"#g" \
  | sed "s#title=\"Introduction\" href=\"\"#title=\"Introduction\" href=\"index.html\"#" \
  | sed "s#src=\"/#src=\"#g" > toc.html

# slim the front page too.
normalize_index_file_names_and_extract_just_the_article "./" false
cat index.html \
    | sed '/<h1>Introduction/d' \
    | sponge index.html

# stitch into PDF book
convert_to_book pdf
convert_to_book mobi
convert_to_book epub
cd ../book/
netlify deploy
cd ..
rm -rf tempHugo/