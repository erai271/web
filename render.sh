#!/bin/bash

set -ue

if [ $# -ne 1 ]; then
  echo "usage: ./render.sh <page.html>" >&2
  exit 1
fi

title="asdf &mdash; Omiltem"
thumbnail="https://omiltem.net/about/pfp.jpg"
description=""
copyright="2024"

eval "$(sed -e '/^$/,$d' "$1")"

if [ -z "${description}" ]; then
  echo "error: no description" >&2
  exit 1
fi

cat << EOF
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>${title}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="@erai271">
    <meta property="og:image" content="${thumbnail}">
    <meta property="og:type" content="article">
    <meta property="og:title" content="${title}">
    <meta property="og:description" content="${description}">
    <meta name="description" content="${description}">
    <link rel="icon" href="/favicon.png">
    <style>$(cat css/style.css)</style>
$(sed -ne '/<head>/,/<\/head>/p' "$1" | sed -e '1d;$d')
  </head>
  <body>
    <header>
      <p class="title">Omiltem</p>
      <nav>
        <ul class="links">
          <li><a href="/">HOME</a></li>
          <li><a href="https://github.com/erai271">CODE</a></li>
          <li><a href="/about">ABOUT</a></li>
        </ul>
      </nav>
    </header>
    <main>
      <article>
        <header>
          <h1>${title}</h1>
        </header>
$(sed -e '1,/^$/d' -e '/<head>/,/<\/head>/d' "$1")
      </article>
    </main>
    <footer>
      &copy; ${copyright} erai
    </footer>
  </body>
</html>
EOF
