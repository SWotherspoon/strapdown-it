#!/usr/bin/env coffee
require 'shelljs/global'

cd __dirname

ver = process.argv[2]
if not ver
  echo 'You need to specify the version'
  exit 1

outDir = 'dist/' + ver

if not test '-d', outDir
  mkdir '-p', outDir
else
  rm '-rf', outDir
  mkdir '-p', outDir


# JS
bundle = ''
bundle += (cat 'vendor/highlight.js') + '\n'
bundle += (cat 'vendor/markdown-it.js') + '\n'
bundle += (cat 'vendor/markdown-it-mathjax.js') + '\n'
bundle += (cat 'vendor/markdown-it-footnote.js') + '\n'
bundle += (cat 'src/strapdown.js') + '\n'
bundle.to outDir + '/strapdown.js'

# CSS
cp '-f', 'src/strapdown.css', outDir
mkdir '-p', outDir + '/themes/bootstrap'
cp '-f', 'vendor/themes/bootstrap/*', outDir + '/themes/bootstrap'
mkdir '-p', outDir + '/themes/highlight'
cp '-f', 'vendor/themes/highlight/*', outDir + '/themes/highlight'

console.log "Bundles generated in #{outDir}/"
