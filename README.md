# FAQ generator

Static generator for creating FAQ html pages from Markdown source.
For each question with answer stored in separate .md file inside `/src/partials/` applied template `/src/layouts/mvno-faq-item.html.eco`. 
The result rendered as html page.

## Install

`npm install`

## Run 

`docpad run` — then open http://localhost:9778
`gulp` — prettify html output

## Hack

```
src/
├── documents/
│   └── *.html.eco                — page content
├── layouts/
│   ├── default.html.eco          — default page template
│   ├── mvno.html.eco             — template for FAQ page
│   └── mvno-faq-item.html.eco    — template for rendering each Q&A
└── partials/
    └── mvno/
        ├── en-us/
        │   └── *.html.md         — Q&As in English
        └── es-us/
            └── *.html.md         — Q&As in Spanish
```

## Deploy

`docpad deploy-ghpages --env static` — check https://idtdesign.github.io/faq-generator/
