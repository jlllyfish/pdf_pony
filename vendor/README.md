# Bibliothèques embarquées

Le widget a l'accès complet aux documents Grist : tout le code qu'il exécute est donc servi depuis ce dépôt, en versions figées, plutôt que depuis des CDN tiers (jsDelivr, esm.sh). Cela supprime une dépendance à des tiers au chargement et n'envoie plus l'adresse IP des agents à ces services.

| Fichier | Bibliothèque | Version | Licence |
|---|---|---|---|
| `tiptap.js` | TipTap (core, starter-kit, image, table, text-align, text-style, suggestion) + ProseMirror, regroupés avec esbuild | 3.31.3 | MIT |
| `pdfmake.min.js` | pdfmake | 0.2.20 | MIT |
| `jszip.min.js` | JSZip | 3.10.1 | MIT ou GPLv3 |
| `dsfr/` | Système de design de l'État (CSS, polices, icônes utilisées) | 1.13.1 | MIT (code) — police Marianne réservée aux services de l'État |
| `remixicon/` | Remix Icon (CSS + polices woff2/woff) | 4.2.0 | Apache 2.0 |

Les textes de licence sont dans `licences/`.

Seul `grist-plugin-api.js` reste chargé depuis `docs.getgrist.com` (code de Grist lui-même).

## Mettre à jour

1. Modifier les versions dans `package.json` (et dans `tiptap-entry.js` si une extension TipTap est ajoutée).
2. Lancer `./maj.sh` (nécessite Node.js) : le script télécharge les paquets npm, régénère les fichiers et nettoie.
3. Tester le widget, puis incrémenter `VERSION` dans `index_pdf.html` et le paramètre `?v=` de l'URL des widgets.

Le script est reproductible : relancé sans changer les versions, il produit des fichiers identiques.
