#!/bin/sh

function extract_just_the_article {
  echo "<html><body>$(xidel --html $1index.html --extract "//article")</body></html>" >  "$1index.html"
  perl -pi -e 's/<!DOCTYPE html>//' "$1index.html"
  perl -pi -e 's/<aside/<aside style="display: none"/' "$1index.html"
  perl -pi -e 's/<footer/<footer style="display: none"/' "$1index.html"

  # change videos to links to videos
  cat $1index.html | sed '/<div noprint/d' | sponge $1index.html
  cat $1index.html | sed 's/<!-- print //' | sponge $1index.html
  cat $1index.html | sed 's/ print -->//' | sponge $1index.html

}

hugo -d tempHugo

cd tempHugo

extract_just_the_article 5-min-overview/
extract_just_the_article alternative-branching-models/
extract_just_the_article branch-by-abstraction/
extract_just_the_article branch-for-release/
extract_just_the_article concurrent-development-of-consecutive-releases/
extract_just_the_article context/
extract_just_the_article continuous-delivery/
extract_just_the_article continuous-integration/
extract_just_the_article continuous-review/
extract_just_the_article deciding-factors/
extract_just_the_article expanding-contracting-monorepos/
extract_just_the_article feature-flags/
extract_just_the_article game-changers/
extract_just_the_article monorepos/
extract_just_the_article monorepos/
extract_just_the_article observed-habits/
extract_just_the_article publications/
extract_just_the_article release-from-trunk/
extract_just_the_article strangulation/
extract_just_the_article vcs-choices/
extract_just_the_article youre-doing-it-wrong/

# Table of contents gets inserted once (was on every page)
echo "<html><body>$(xidel --html index.html --extract "//div[@class='drawer']")<br/>Book transformation of <a href='https://trunkbaseddevelopment.com'>TrunkBasedDevelopment.com</a><br/>Copyright 2017: Paul Hammant and Steve Smith<br/>This book is free (gratis) to copy as long as you don't modify it, otherwise your owe us \$1,000,000 USD<br/>Generated $(git log | head -n 3 | grep Date)</body></html>" >  "toc.html"
perl -pi -e 's/<!DOCTYPE html>//' "toc.html"
perl -pi -e 's/<aside/<aside style="display: none"/' "$1index.html"

extract_just_the_article ""

ebook-convert toc.html ../trunk_based_development_book.pdf --page-breaks-before "//h:h1" --breadth-first
