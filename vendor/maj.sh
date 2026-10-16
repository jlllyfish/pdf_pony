#!/usr/bin/env bash
# Régénère le dossier vendor/ à partir des versions figées dans package.json.
# Usage : cd vendor && ./maj.sh   (nécessite Node.js)
set -euo pipefail
cd "$(dirname "$0")"
npm ci --no-audit --no-fund 2>/dev/null || npm install --no-audit --no-fund
N=node_modules
npx esbuild tiptap-entry.js --bundle --format=esm --minify --legal-comments=eof --target=es2020 --outfile=tiptap.js
cp $N/pdfmake/build/pdfmake.min.js pdfmake.min.js
cp $N/jszip/dist/jszip.min.js jszip.min.js
rm -rf dsfr && mkdir -p dsfr/fonts
cp $N/@gouvfr/dsfr/dist/dsfr.min.css dsfr/
cp $N/@gouvfr/dsfr/dist/fonts/*.woff* dsfr/fonts/
grep -o 'url([^)]*)' dsfr/dsfr.min.css | sed 's/url(//;s/)//;s/["'"'"']//g' | grep '^icons/' | sort -u |
  while read -r f; do mkdir -p "dsfr/$(dirname "$f")"; cp "$N/@gouvfr/dsfr/dist/$f" "dsfr/$f"; done
mkdir -p remixicon
cp $N/remixicon/fonts/remixicon.woff2 $N/remixicon/fonts/remixicon.woff remixicon/
node -e '
  const fs = require("fs");
  const css = fs.readFileSync("node_modules/remixicon/fonts/remixicon.css", "utf8").replace(/@font-face\s*\{[\s\S]*?\}/,
    `@font-face {\n  font-family: "remixicon";\n  src: url("remixicon.woff2") format("woff2"), url("remixicon.woff") format("woff");\n  font-display: swap;\n}`);
  fs.writeFileSync("remixicon/remixicon.css", css);'
rm -rf node_modules package-lock.json
echo "vendor/ régénéré. Pensez à mettre à jour les empreintes SRI (README.md)."
