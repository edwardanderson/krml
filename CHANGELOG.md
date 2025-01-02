# Changelog

## 3.1.2

- Fix handling of consecutive paragraphs
- Fix specification formatting where some `<details/>` elements were missing

## 3.1.1

- Fix code to pass test 2.6.a

## 3.1.0

- Refactor specification tests to use `pytest`

## 3.0.0-alpha

- Rename project to Knowledge Representation Markup Language
- Refactor specification and implementation
- Add testmark fixtures to the specification
- Improve CLI
  - Option: Rich syntax highlighting
  - Option: embed context document

## 2.14.4

- Add test for asserting language of image caption
- Rename `frontmatter-metadata` parameter to `metadata`

## 2.14.3

- Start factoring source/result documents into separate classes
- Add parsing for h1 title

## 2.14.2

- Add `--debug` option
- Only name referenced blank nodes
- Add test for date between 1 and 1000 CE
- Add Getting Started docs

## 2.14.1

- Fix misassignment of language to plain-text representation of HTML text

## 2.14.0

- Support muliple paragraphs in block quotes

## 2.13.0

- Detect tests at any heading depth
- Stop breaking blockquote lines

## 2.12.0

- Parameterise embedding `@context`
- Extend tests to include `ol` object sequences
- Parameterise `_sameAs`

## 2.11.3

- Fix empty image label

## 2.11.2

- Prefer `false` defaults

## 2.11.1

- Extend tests manifest
- General bug fixes:
  - Fix assignment of global class
  - Progress towards multi-line blockquotes

## 2.11.0

- Simple tests scaffolding and examples

## 2.10.0

- Create a plain text representation of styled blockquote text

## 2.9.1

- Fix bug in blockquote hyperlink label mapping to `rdfs:seeAlso`

## 2.9.0

- Generate `owl:sameAs` relations for entities with two or more definition list entries

## 2.8.0

- Add basic Dublin Core statements about the Markdown document dataset

## 2.7.2

- Extend example, reserialise data
- Prefer `longturtle` serialisation for readability
- Fix blank node creation when blockquote has image but no hyperlink
- Prefer `html:img` to `schema:ImageObject` as default image class

## 2.7.1

- Create `rdfs:seeAlso` references for images inside blockquotes
- Always use `-` list item delimiter in examples
- Fix missing default `@language` on untyped and unstyled blockquotes
- Resources referenced in blockquotes get labels with language tags:
  1. inherited from the language of the blockquote text
  2. according to the document default language
- Improve CLI error handling for unrecognised RDF serialisation syntax

## 2.7.0

- Support glossary sidecar file for external definition lists.
  Example: [glossary.md](examples/features/glossary.md)

## 2.6.0

- Add error reporting to transformation failure

## 2.5.0

- Support ordered lists (as objects only)
- Add input path validation

## 2.4.2

- Fix single class

## 2.4.1

- Fix bad handling of `None` when stripping new line characters from `li` elements

## 2.4.0

- Support definition lists for subjects and objects

## 2.3.0

- Support for typographic conventions like (c)
- Granular detection of `xsd` type when user specifies `date`

## 2.2.1

- Fix failure to map 'a' to `rdf:type` caused by unexpected newline

## 2.2.0

- Add support for named graphs

## 2.1.0

- Add support for tables

## 2.0.0

- Simplify everything

## 0.1.5

### Fixed

- Replaced semantics for `_comment` from `rdfs:comment` to `schema:comment` as range was Literal.
- `Path()` was mangling `@vocab`

## 0.1.4

### Fixed

- Update installation instructions.

## 0.1.3

### Fixed

- Update licence in setup.py.

## 0.1.2

### Fixed

- Fixed bug in Markdown resource URI-ification causing ".md" substring to be replaced when not in end position.

## 0.1.1

### Fixed

- Links to Markdown resources are now URI-ified:
  - `[](location.md)` → `{"id": "location"}`
  - `[](location.md#section)` → `{"id": "location#section"}`
