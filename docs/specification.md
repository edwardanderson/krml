---
title: Specification of the Knowledge Representation Markup Language
author: Edward Anderson
---

# Specification of the Knowledge Representation Markup Language

- [Specification of the Knowledge Representation Markup Language](#specification-of-the-knowledge-representation-markup-language)
  - [1. Body](#1-body)
    - [1.1. Structure](#11-structure)
      - [1.1.1. Graph](#111-graph)
        - [1.1.1.1. Unordered](#1111-unordered)
        - [1.1.1.2. Ordered](#1112-ordered)
      - [1.1.2. Comment](#112-comment)
      - [1.1.3. Definition List](#113-definition-list)
    - [1.2. Resource](#12-resource)
      - [1.2.1. Hyperlink](#121-hyperlink)
        - [1.2.1.1. Label](#1211-label)
        - [1.2.1.2. Class](#1212-class)
      - [1.2.2. Plain Text](#122-plain-text)
        - [1.2.2.1. Anonymous](#1221-anonymous)
        - [1.2.2.2. Identified](#1222-identified)
      - [1.2.3. Blockquote](#123-blockquote)
        - [1.2.3.1. Identified](#1231-identified)
        - [1.2.3.2. Reified](#1232-reified)
        - [1.2.3.3. Language](#1233-language)
        - [1.2.3.4. Style](#1234-style)
        - [1.2.3.5. Reference](#1235-reference)
        - [1.2.3.6. Datatype](#1236-datatype)
          - [1.2.3.6.1. Boolean](#12361-boolean)
        - [1.2.3.7. Number](#1237-number)
      - [1.2.4. Image](#124-image)
      - [1.2.5. Code Block](#125-code-block)
      - [1.2.6. Table](#126-table)
    - [1.3. Syntax](#13-syntax)
  - [2. Frontmatter](#2-frontmatter)
    - [2.1. Base](#21-base)
    - [2.2. Vocab](#22-vocab)
    - [2.3. Language](#23-language)
    - [2.4. Import](#24-import)
    - [2.5. Identifier](#25-identifier)
    - [2.6. Title](#26-title)

This document specifies the Knowledge Representation Markup Language (KRML). It includes [go-testmark](https://github.com/warpfork/go-testmark) integration test fixtures, with input scenarios each accompanied by an expected Turtle graph shape and an expected JSON-LD serialisation.

A KRML document is a plain-text Markdown document that complies with the following conventions for structure format and syntax.

## 1. Body

### 1.1. Structure

#### 1.1.1. Graph

Graphs of triples are composed of nests of either [unordered](#unordered) or [ordered](#ordered) lists of [resources](#resources).

##### 1.1.1.1. Unordered

[testmark]:# (1.1.1.1.a. arrange)
```markdown
- John
  - knows
    - Paul
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.1.1.1.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :knows [ rdfs:label "Paul" ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.1.1.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "knows": [
        {
          "_label": "Paul"
        }
      ]
    }
  ]
}
```

</details>

##### 1.1.1.2. Ordered

Objects may be listed in sequence.

[testmark]:# (1.1.1.2.a. arrange)
```markdown
- John
  - spouse
    1. Cynthia
    2. Yoko
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.1.1.2.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :spouse (
        [ rdfs:label "Cynthia" ]
        [ rdfs:label "Yoko" ]
    ) .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.1.1.2.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "spouse": {
        "@list": [
           {
             "_label": "Cynthia"
           },
           {
             "_label": "Yoko"
           }
         ]
       }
    }
  ]
}
```

</details>

#### 1.1.2. Comment

Comments not intended to be represented in data may be given in HTML.

[testmark]:# (1.1.2.a. arrange)
```markdown
<!-- Content inside HTML comment tags is ignored. -->

- John
  <!-- Consider using foaf:knows -->
  - knows
    - Paul
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.1.2.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
  :knows [ rdfs:label "Paul" ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.1.2.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "knows": [
        {
          "_label": "Paul"
        }
      ]
    }
  ]
}
```

</details>

#### 1.1.3. Definition List

Definition lists may be use to identify [plain text resources](#122-plain-text) in the [graph](#111-graph).

[testmark]:# (1.1.3.a. arrange)
```markdown
- John
  - date of birth
    - > 1940-10-09 `date`
  - born in
    - Liverpool
- Paul
  - born in
    - Liverpool

John
: <http://www.wikidata.org/entity/Q1203>

date of birth
: <https://schema.org/birthDate>

date
: <http://www.w3.org/2001/XMLSchema#date>

born in
: <https://schema.org/birthPlace>

Liverpool
: <http://www.wikidata.org/entity/Q24826>
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.1.3.a. assert-graph)
```turtle
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix schema: <https://schema.org/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<http://www.wikidata.org/entity/Q1203> rdfs:label "John" ;
  schema:birthPlace <http://www.wikidata.org/entity/Q24826> ;
  schema:birthDate "1940-10-09"^^xsd:date .

[] rdfs:label "Paul" ;
  schema:birthPlace <http://www.wikidata.org/entity/Q24826> .

<http://www.wikidata.org/entity/Q24826> rdfs:label "Liverpool" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.1.3.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/",
      "date%20of%20birth": {
        "@id": "https://schema.org/birthDate",
        "@container": "@set"
      },
      "date": {
        "@id": "http://www.w3.org/2001/XMLSchema#date",
        "@type": "@id"
      },
      "born%20in": {
        "@id": "https://schema.org/birthPlace",
        "@container": "@set"
      }
    }
  ],
  "@graph": [
    {
      "@id": "http://www.wikidata.org/entity/Q1203",
      "_label": "John",
      "date%20of%20birth": [
        {
          "@type": "date",
          "@value": "1940-10-09"
        }
      ],
      "born%20in": [
        {
          "@id": "http://www.wikidata.org/entity/Q24826",
          "_label": "Liverpool"
        }
      ]
    },
    {
      "_label": "Paul",
      "born%20in": [
        {
          "@id": "http://www.wikidata.org/entity/Q24826",
          "_label": "Liverpool"
        }
      ]
    }
  ]
}
```

</details>

### 1.2. Resource

Resources may be [hyperlinks](#hyperlink), [plain-text](#plain-text), [blockquotes](#blockquote) or [images](#image).

#### 1.2.1. Hyperlink

Hyperlinks are composed of an IRI and, optionally, a [label](#label) and/or a [class](#class). If no label is provided, the resource is labelled with the last segment of the path.

IRIs may be absolute or relative. Resources are resolved relative to the [base](#base), which can be set in the document frontmatter.

[testmark]:# (1.2.1.a. arrange)
```markdown
- [John](http://example.org/john)
- <http://example.org/paul>
- [](http://example.org/george)
- [Ringo][1]

[1]: http://example.org/ringo
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.1.a. assert-graph)
```turtle
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://example.org/john> rdfs:label "John" .

<http://example.org/paul> rdfs:label "paul" .

<http://example.org/george> rdfs:label "george" .

<http://example.org/ringo> rdfs:label "Ringo" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "http://example.org/john",
      "_label": "John"
    },
    {
      "@id": "http://example.org/paul",
      "_label": "paul"
    },
    {
      "@id": "http://example.org/george",
      "_label": "george"
    },
    {
      "@id": "http://example.org/ringo",
      "_label": "Ringo"
    }
  ]
}
```

</details>

##### 1.2.1.1. Label

The language of the label may be specified. Trailing spaces are not preserved. To preserve the trailing space use a [whitespace character](https://en.wikipedia.org/wiki/Whitespace_character).

[testmark]:# (1.2.1.1.a. arrange)
```markdown
- [John `en`](http://example.org/john)
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.1.1.a. assert-graph)
```turtle
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://example.org/john> rdfs:label "John"@en .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.1.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "http://example.org/john",
      "_label": {
        "@language": "en",
        "@value":  "John"
      }
    }
  ]
}
```

</details>

The label may be [styled](#style).

[testmark]:# (1.2.1.1.b. arrange)
```markdown
- [**John**](http://example.org/john)
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.1.1.b. assert-graph)
```turtle
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://example.org/john> rdfs:label "<p><strong>John</strong></p>"^^rdf:HTML .
```

</details>

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.1.1.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "http://example.org/john",
      "_label": {
        "@type": "_HTML",
        "@value":  "<p><strong>John</strong></p>"
      }
    }
  ]
}
```

</details>

##### 1.2.1.2. Class

The predicate keyword `a` can be provided to specify the `rdf:type` of a resource.

[testmark]:# (1.2.1.2.a. arrange)
```markdown
- John
  - a
    - Person
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.1.2.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    a :Person .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.1.2.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "@type": [
        "Person"
      ]
    }
  ]
}
```

</details><br/>

The tokens `â` or `^a` may be used to inverse the direction of the class assignment.

[testmark]:# (1.2.1.2.b. arrange)
```markdown
- Person
  - â
    - John
    - Paul
    - George
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.1.2.b. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    a :Person .

[] rdfs:label "Paul" ;
    a :Person .

[] rdfs:label "George" ;
    a :Person .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.1.2.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "@type": [
        "Person"
      ]
    },
    {
      "_label": "Paul",
      "@type": [
        "Person"
      ]
    },
    {
      "_label": "George",
      "@type": [
        "Person"
      ]
    }
  ]
}
```

</details>

Hyperlinks may include a class by overloading the hyperlink's `title` attribute with an IRI or a defined term.

[testmark]:# (1.2.1.2.c. arrange)
```markdown
- [John](http://example.org/john "http://example.org/terms/Person")
  - [knows](http://xmlns.com/foaf/0.1/knows "http://www.w3.org/2002/07/owl#SymmetricProperty")
    - [Paul](http://example.org/paul "Person")

Person
: <https://schema.org/Person>
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.1.2.c. assert-graph)
```turtle
@prefix : <http://example.org/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://example.org/john> rdfs:label "John" ;
    a <http://example.org/terms/Person> ;
    foaf:knows <http://example.org/paul> .

<http://example.org/paul> rdfs:label "Paul" ;
    a <https://schema.org/Person> .

foaf:knows a owl:SymmetricProperty ;
  rdfs:label "knows" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.1.2.c. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/",
      "Person": {
        "@id": "https://schema.org/Person",
        "@container": "@set"
      }
    }
  ],
  "@graph": [
    {
      "@id": "http://example.org/john",
      "@type": [
        "http://example.org/terms/Person"
      ],
      "_label": "John",
      "http://xmlns.com/foaf/0.1/knows": [
        {
          "@id": "http://example.org/paul",
          "@type": [
            "Person"
          ],
          "_label": "Paul"
        }
      ]
    },
    {
      "@id": "http://xmlns.com/foaf/0.1/knows",
      "@type": [
        "http://www.w3.org/2002/07/owl#SymmetricProperty"
      ],
      "_label": "knows"
    }
  ]
}
```

</details>

#### 1.2.2. Plain Text

##### 1.2.2.1. Anonymous

Subject and object resources in plain text are labelled anonymous (blank node) resources. They can be referred to by their label within the document.

[testmark]:# (1.2.2.1.a. arrange)
```markdown
- John
  - knows
    - Paul
      - knows
        - John
- Paul
  - birth place
    - Liverpool
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.2.1.a. assert-graph)
```turtle
@prefix : <http://example.org/> .
@prefix exterms: <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

_:John rdfs:label "John" ;
  exterms:knows _:Paul .

_:Paul rdfs:label "Paul" ;
  exterms:knows _:John ;
  exterms:birth%20place [ rdfs:label "Liverpool" ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.2.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "_:John",
      "_label": "John",
      "knows": [
        {
          "@id": "_:Paul",
          "_label": "Paul",
          "knows": [
            {
              "@id": "_:John",
              "_label": "John"
            }
          ]
        }
      ]
    },
    {
      "@id": "_:Paul",
      "_label": "Paul",
      "birth%20place": [
        {
          "_label": "Liverpool"
        }
      ]
    }
  ]
}
```

</details>

Resources that share labels but are unique from each other can be disambiguated by wrapping the label in double quotation marks.

[testmark]:# (1.2.2.1.b. arrange)
```markdown
- John
  - mother
    - "Julia"
  - half sister
    - "Julia"
  - wrote
    - Julia
      - a
        - Song
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.2.1.b. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :mother [ rdfs:label "Julia" ] ;
    :half%20sister [ rdfs:label "Julia" ] ;
    :wrote [
        rdfs:label "Julia" ;
        a :Song
    ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.2.1.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "mother": [
        {
          "_label": "Julia"
        }
      ],
      "half%20sister": [
        {
          "_label": "Julia"
        }
      ],
      "wrote": [
        {
          "_label": "Julia",
          "@type": [
            "Song"
          ]
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.2.2. Identified

Plain text resources may be identified with definition lists.

[testmark]:# (1.2.2.2.a. arrange)
```markdown
- John
  - knows
    - Paul

John
: <http://www.wikidata.org/entity/Q1203>

knows
: <http://xmlns.com/foaf/0.1/knows>
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.2.2.a. assert-graph)
```turtle
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://www.wikidata.org/entity/Q1203> rdfs:label "John" ;
    foaf:knows [ rdfs:label "Paul" ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.2.2.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/",
      "knows": {
        "@id": "http://xmlns.com/foaf/0.1/knows",
        "@container": "@set"
      }
    }
  ],
  "@graph": [
    {
      "@id": "http://www.wikidata.org/entity/Q1203",
      "_label": "John",
      "knows": [
        {
          "_label": "Paul"
        }
      ]
    }
  ]
}
```

</details>

Resources with multiple definitions have the same identity.

[testmark]:# (1.2.2.d. arrange)
```
- John

John
: <http://www.wikidata.org/entity/Q1203>
: <https://vocab.getty.edu/ulan/500106615>
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.2.d. assert-graph)
```turtle
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://www.wikidata.org/entity/Q1203> rdfs:label "John" ;
    owl:sameAs <https://vocab.getty.edu/ulan/500106615> .

<https://vocab.getty.edu/ulan/500106615> rdfs:label "John" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.2.d. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "http://www.wikidata.org/entity/Q1203",
      "_label": "John"
    },
    {
      "@id": "http://www.wikidata.org/entity/Q1203",
      "_sameAs": [
        {
          "@id": "https://vocab.getty.edu/ulan/500106615",
          "_label": "John"
        }
      ]
    }
  ]
}
```

</details>

#### 1.2.3. Blockquote

Blockquotes contain literal text.

[testmark]:# (1.2.3.a. arrange)
```markdown
- John
  - name
    - > John Winston Lennon
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :name "John Winston Lennon" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "name": [
        {
          "@value": "John Winston Lennon"
        }
      ]
    }
  ]
}
```

</details>

Consecutive paragraphs are concatenated with newline characters.

[testmark]:# (1.2.3.b. arrange)
```markdown
- John
  - description
    - > John Winston Ono Lennon was an English singer-songwriter.
      >
      > Born in Liverpool, Lennon became involved in the skiffle craze.
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.b. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :description "John Winston Ono Lennon was an English singer-songwriter.\nBorn in Liverpool, Lennon became involved in the skiffle craze." .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "description": [
        {
          "@value": "John Winston Ono Lennon was an English singer-songwriter.\nBorn in Liverpool, Lennon became involved in the skiffle craze."
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.1. Identified

A preceding sibling hyperlink identifies the blockquote.

[testmark]:# (1.2.3.1.a. arrange)
```markdown
- John
  - description
    - [biography](http://example.org/biography/1)
      > Born in Liverpool, Lennon became involved in the skiffle craze as a teenager.
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.1.a. assert-graph)
```turtle
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix exterms: <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    exterms:description <http://example.org/biography/1> .

<http://example.org/biography/1>
    a dcmitype:Text ;
    rdfs:label "biography" ;
    rdf:value "Born in Liverpool, Lennon became involved in the skiffle craze as a teenager." .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "description": [
        {
          "@id": "http://example.org/biography/1",
          "_label": "biography",
          "@type": [
            "_Text"
          ],
          "_content": {
            "@value": "Born in Liverpool, Lennon became involved in the skiffle craze as a teenager."
          }
        }
      ]
    }
  ]
}
```

</details>

A plain-text resource may also identify the blockquote in the local scope.

[testmark]:# (1.2.3.1.b. arrange)
```markdown
- John
  - name
    - name a
      > John Winston Lennon
    - name b
      > John Winston Ono Lennon
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.1.b. assert-graph)
```turtle
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix exterms: <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    exterms:name _:a , _:b .

_:a rdfs:label "name a" ;
    a dcmitype:Text ;
    rdf:value "John Winston Lennon" .

_:b rdfs:label "name b" ;
    a dcmitype:Text ;
    rdf:value "John Winston Ono Lennon" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.1.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "name": [
        {
          "@id": "_:name%20a",
          "_label": "name a",
          "@type": [
            "_Text"
          ],
          "_content": {
            "@value": "John Winston Lennon"
          }
        },
        {
          "@id": "_:name%20b",
          "_label": "name b",
          "@type": [
            "_Text"
          ],
          "_content": {
            "@value": "John Winston Ono Lennon"
          }
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.2. Reified

Making a statement about a blockquote reifies it.

[testmark]:# (1.2.3.2.a. arrange)
```markdown
- John
  - description
    - > He gained worldwide fame as the founder, co-lead vocalist and rhythm guitarist of the Beatles.
      - source
        - [Wikipedia](http://www.wikidata.org/entity/Q52)
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.2.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :description [
        a dcmitype:Text ;
        rdf:value "He gained worldwide fame as the founder, co-lead vocalist and rhythm guitarist of the Beatles." ;
        :source <http://www.wikidata.org/entity/Q52>
    ] .

<http://www.wikidata.org/entity/Q52> rdfs:label "Wikipedia" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.2.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "description": [
        {
          "@type": [
            "_Text"
          ],
          "_content": {
            "@value": "He gained worldwide fame as the founder, co-lead vocalist and rhythm guitarist of the Beatles."
          },
          "source": [
            {
              "@id": "http://www.wikidata.org/entity/Q52",
              "_label": "Wikipedia"
            }
          ]
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.3. Language

A [BCP47](https://en.wikipedia.org/wiki/IETF_language_tag) language tag may be specified in code fences at the end of the line.

[testmark]:# (1.2.3.3.a. arrange)
```markdown
- John
  - said
    - > You may say I'm a dreamer `en`
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.3.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :said "You may say I'm a dreamer"@en .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.3.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "said": [
        {
          "@language": "en",
          "@value": "You may say I'm a dreamer"
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.4. Style

Styled text is serialised as HTML.

[testmark]:# (1.2.3.4.a. arrange)
```markdown
- John
  - note
    - > **John Winston Ono Lennon** was an English singer, songwriter and musician. 
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.4.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :note "<p><strong>John Winston Ono Lennon</strong> was an English singer, songwriter and musician.</p>"^^rdf:HTML .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.4.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "note": [
        {
          "@type": "_HTML",
          "@value": "<p><strong>John Winston Ono Lennon</strong> was an English singer, songwriter and musician.</p>"
        }
      ]
    }
  ]
}
```

</details>

Specifying the language of styled text attributes the paragraph `p`.

[testmark]:# (1.2.3.4.b. arrange)
```markdown
- Paul
  - note
    - > **Sir James Paul McCartney** CH MBE (born 18 June 1942) is an English singer `en`
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.4.b. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "Paul" ;
    :note "<p lang=\"en\"><strong>Sir James Paul McCartney</strong> CH MBE (born 18 June 1942) is an English singer</p>"^^rdf:HTML .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.4.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "Paul",
      "note": [
        {
          "@type": "_HTML",
          "@value": "<p lang=\"en\"><strong>Sir James Paul McCartney</strong> CH MBE (born 18 June 1942) is an English singer</p>"
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.5. Reference

[Hyperlinks](#hyperlink) and [images](#image) inside blockquotes are materialised as references.

[testmark]:# (1.2.3.5.a. arrange)
```markdown
- John
  - description
    - > In 1956, he formed the [Quarrymen](https://en.wikipedia.org/wiki/The_Quarrymen)
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.5.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :description [
        a dcmitype:Text ;
        rdf:value "<p>In 1956, he formed the <a href=\"https://en.wikipedia.org/wiki/The_Quarrymen\">Quarrymen</a></p>"^^rdf:HTML ;
        rdfs:seeAlso <https://en.wikipedia.org/wiki/The_Quarrymen>
    ] .

<https://en.wikipedia.org/wiki/The_Quarrymen> rdfs:label "Quarrymen" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.5.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "description": [
        {
          "@type": [
            "_Text"
          ],
          "_content": {
            "@type": "_HTML",
            "@value": "<p>In 1956, he formed the <a href=\"https://en.wikipedia.org/wiki/The_Quarrymen\">Quarrymen</a></p>"
          },
          "_seeAlso": [
            {
              "@id": "https://en.wikipedia.org/wiki/The_Quarrymen",
              "_label": "Quarrymen"
            }
          ]
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.6. Datatype

An arbitrary datatype may be given.

[testmark]:# (1.2.3.6.a. arrange)
```markdown
- John
  - date of birth
    - > 1940-10-09 `date`
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.6.a. assert-graph)
```turtle
@prefix exterms: <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    exterms:date%20of%20birth "1940-10-09"^^exterms:date .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.6.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "date%20of%20birth": [
        {
          "@type": "date",
          "@value": "1940-10-09"
        }
      ]
    }
  ]
}
```

</details>

A datatype may be given as a code-fenced reference to a defined term.

[testmark]:# (1.2.3.6.b. arrange)
```markdown
- John
  - date of birth
    - > 1940-10-09 `date`

date
: <http://www.w3.org/2001/XMLSchema#date>
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.6.b. assert-graph)
```turtle
@prefix exterms: <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

[] rdfs:label "John" ;
    exterms:date%20of%20birth "1940-10-09"^^xsd:date .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.6.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/",
      "date": {
        "@id": "http://www.w3.org/2001/XMLSchema#date",
        "@type": "@id"
      }
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "date%20of%20birth": [
        {
          "@type": "date",
          "@value": "1940-10-09"
        }
      ]
    }  
  ]
}
```

</details>


To escape a code-fenced term from being processed as a [language](#language) or [datatype](#datatype), add a non-breaking space character `&#160;`.

[testmark]:# (1.2.3.6.c. arrange)
```markdown
- John
  - said
    - > It's been too long since we took the `time`&#160;
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.6.c. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :said "<p>It's been too long since we took the <code>time</code></p>"^^rdf:HTML .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.6.c. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "said": [
        {
          "@type": "_HTML",
          "@value": "<p>It's been too long since we took the <code>time</code></p>"
        }
      ]
    }  
  ]
}
```

</details>

###### 1.2.3.6.1. Boolean

Booleans may be set using the built-in `boolean` datatype token.

[testmark]:# (1.2.3.6.1.a. arrange)
```markdown
- John
  - alive
    - > false `boolean`
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.6.1.a. assert-graph)
```turtle
@prefix exterms: <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

[] rdfs:label "John" ;
    exterms:alive false .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.6.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "alive": [
        {
          "@type": "_boolean",
          "@value": "false"
        }
      ]
    }
  ]
}
```

</details>

##### 1.2.3.7. Number

Numbers are detected automatically.

[testmark]:# (1.2.3.7.a. arrange)
```
- John
  - children
    - > 2
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.3.7.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John" ;
    :children 2 .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.3.7.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "children": [
        {
          "@value": 2
        }
      ]
    }  
  ]
}
```

</details>

#### 1.2.4. Image

[testmark]:# (1.2.4.a. arrange)
```markdown
- ![John Lennon, 1974 (restored cropped)](https://shorturl.at/SacIh)
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.4.a. assert-graph)
```turtle
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<https://shorturl.at/SacIh> a dcmitype:Image ;
  rdfs:label "John Lennon, 1974 (restored cropped)" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.4.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "https://shorturl.at/SacIh",
      "_label": "John Lennon, 1974 (restored cropped)",
      "@type": [
        "_Image"
      ]
    }  
  ]
}
```

</details>

Image classes may be specified in the same way as for [hyperlink classes](#class).

#### 1.2.5. Code Block

[testmark]:# (1.2.5.a. arrange)
````markdown
- Yesterday
  - lyrics
    - ```text
      There are places I remember
      All my life, though some have changed
      ```
````

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.5.a. assert-graph)
```turtle
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix exterms: <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "Yesterday" ;
  exterms:lyrics [
    a dcmitype:Text ;
    dcterms:format "text" ;
    rdf:value """There are places I remember
All my life, though some have changed
""" ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.5.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "Yesterday",
      "lyrics": [
        {
          "@type": [
            "_Text"
          ],
          "_format": "text",
          "_content": {
            "@value":"There are places I remember\nAll my life, though some have changed\n"
          }
        }
      ]
    }
  ]
}
```

</details>

Another example.

[testmark]:# (1.2.5.b. arrange)
````markdown
- ```text
  . 　　 　　　　　
  　·   ·   　    　
  　 ·  ✦ * 
   ✵  . 　　　　·  ·  ⋆  　 
     ✫  ✵  ·　　✵   　　 ˚ 
  · 　  ✵ 　　 　 .  ·
  ```
  - source
    - <https://x.com/tiny_star_field/status/1681381641753640960>
````

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.5.b. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix dcmitype: <http://purl.org/dc/dcmitype/> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] a dcmitype:Text ; 
  dcterms:format "text" ; 
  rdf:value """. 　　 　　　　　
　·   ·   　    　
　 ·  ✦ * 
 ✵  . 　　　　·  ·  ⋆  　 
   ✫  ✵  ·　　✵   　　 ˚ 
· 　  ✵ 　　 　 .  ·
""" ;
  :source <https://x.com/tiny_star_field/status/1681381641753640960> .

<https://x.com/tiny_star_field/status/1681381641753640960> rdfs:label "1681381641753640960" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.5.b. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@type": [
        "_Text"
      ],
      "_format": "text",
      "_content": {
        "@value": ". 　　 　　　　　\n　·   ·   　    　\n　 ·  ✦ * \n ✵  . 　　　　·  ·  ⋆  　 \n   ✫  ✵  ·　　✵   　　 ˚ \n· 　  ✵ 　　 　 .  ·\n"
      },
      "source": [
        {
          "@id": "https://x.com/tiny_star_field/status/1681381641753640960",
          "_label": "1681381641753640960"
        }
      ]
    }
  ]
}
```

</details>

#### 1.2.6. Table

Tables are handled as HTML. It may be preferable to represent information semantically instead or as well.

[testmark]:# (1.2.6.a. arrange)
```markdown
- The Beatles
  - albums
    - | Title              | Year |
      |-                   |-     |
      | Please Please Me   | 1963 |
      | With the Beatles   | 1963 |
      | A Hard Day's Night | 1964 |
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (1.2.6.a. assert-graph)
```turtle
@prefix exterms: <http://example.org/terms/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix schema: <https://schema.org/> .

[] rdfs:label "The Beatles" ;
    exterms:albums [
      a schema:Table ;
      rdf:value "<table><thead><tr><th>Title</th><th>Year</th></tr></thead><tbody><tr><td>Please Please Me</td><td>1963</td></tr><tr><td>With the Beatles</td><td>1963</td></tr><tr><td>A Hard Day's Night</td><td>1964</td></tr></tbody></table>"^^rdf:HTML ] .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (1.2.6.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "_label": "The Beatles",
      "albums": [
        {
          "@type": [
            "_Table"
          ],
          "_content": {
            "@type": "_HTML",
            "@value": "<table><thead><tr><th>Title</th><th>Year</th></tr></thead><tbody><tr><td>Please Please Me</td><td>1963</td></tr><tr><td>With the Beatles</td><td>1963</td></tr><tr><td>A Hard Day's Night</td><td>1964</td></tr></tbody></table>"
          }
        }
      ]
    }
  ]
}
```

</details>

Inserting hyperlinks or images into cells will reify the table as a blank node and generate [references](#reference).

### 1.3. Syntax

## 2. Frontmatter

### 2.1. Base

Resolve relative IRIs against the specified base.

[testmark]:# (2.1.a. arrange)
```markdown
---
base: http://example.org/
---

- [John](people/1 "Person")
- [Paul](people/2 "Person")
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (2.1.a. assert-graph)
```turtle
@base <http://example.org/> .
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<people/1> rdfs:label "John" ;
  a :Person .

<people/2> rdfs:label "Paul" ;
  a :Person .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (2.1.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@graph": [
    {
      "@id": "people/1",
      "@type": [
        "Person"
      ],
      "_label": "John"
    },
    {
      "@id": "people/2",
      "@type": [
        "Person"
      ],
      "_label": "Paul"
    }
  ]
}
```

</details>

### 2.2. Vocab

Set the default vocabulary, which can be overriden by local or [imported](#24-import) identity definitions.

[testmark]:# (2.2.a. arrange)
```markdown
---
vocab: https://schema.org/
---

- John
  - a
    - [Person](http://xmlns.com/foaf/0.1/Person)
  - knows
    - Paul
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (2.2.a. assert-graph)
```turtle
@prefix : <http://example.org/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix schema: <https://schema.org/> .

[] a foaf:Person ;
    rdfs:label "John" ;
    schema:knows [ rdfs:label "Paul" ] .

foaf:Person rdfs:label "Person" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (2.2.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "https://schema.org/"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "@type": [
        "http://xmlns.com/foaf/0.1/Person"
      ],
      "knows": [
        {
          "_label": "Paul"
        }
      ]
    },
    {
      "@id": "http://xmlns.com/foaf/0.1/Person",
      "_label": "Person"
    }
  ]
}
```

</details>

### 2.3. Language

Set the default language for all strings, unless overridden in-line.

[testmark]:# (2.3.a. arrange)
```markdown
---
language: en
---

- John
  - said
    - > I believe in everything until it's disproved
- Yoko
  - name
    - > 小野 洋子 `jp`
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (2.3.a. assert-graph)
```turtle
@prefix : <http://example.org/terms/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "John"@en ;
  :said "I believe in everything until it's disproved"@en .

[] rdfs:label "Yoko"@en ;
  :name "小野 洋子"@jp .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (2.3.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/",
      "@language": "en"
    }
  ],
  "@graph": [
    {
      "_label": "John",
      "said": [
        {
          "@language": "en",
          "@value": "I believe in everything until it's disproved"
        }
      ]
    },
    {
      "_label": "Yoko",
      "name": [
        {
          "@language": "jp",
          "@value": "小野 洋子"
        }
      ]
    }
  ]
}
```

</details>

### 2.4. Import

Import data from another file.

> ```markdown
> John
> : <http://www.wikidata.org/entity/Q1203>
>
> date
> : <http://www.w3.org/2001/XMLSchema#date>
>
> date of birth
> : <https://schema.org/birthDate>
> ```
>
> -- [terms.md](../tests/extra/terms.md)

[testmark]:# (2.4.a. arrange)
```markdown
---
import: tests/extra/terms.md
---

- John
  - date of birth
    - > 1940-10-09 `date`
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (2.4.a. assert-graph)
```turtle
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix schema: <https://schema.org/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<http://www.wikidata.org/entity/Q1203> rdfs:label "John" ;
    schema:birthDate "1940-10-09"^^xsd:date .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (2.4.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/",
      "date%20of%20birth": {
        "@id": "https://schema.org/birthDate",
        "@container": "@set"
      },
      "date": {
        "@id": "http://www.w3.org/2001/XMLSchema#date",
        "@type": "@id"
      }
    }
  ],
  "@graph": [
    {
      "@id": "http://www.wikidata.org/entity/Q1203",
      "_label": "John",
      "date%20of%20birth": [
        {
          "@type": "date",
          "@value": "1940-10-09"
        }
      ]
    }
  ]
}
```

</details>

### 2.5. Identifier

Set the URI of the named graph.

[testmark]:# (2.5.a. arrange)
```markdown
---
id: docs/1
---
```

<details><summary><code>application/trig</code></summary>

[testmark]:# (2.5.a. assert-graph)
```turtle
@base <http://exaple.org/> .

<docs/1> {

}
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (2.5.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "@id": "docs/1",
  "@graph": []
}
```

</details>

### 2.6. Title

Set a label for the (un)named graph.

[testmark]:# (2.6.a. arrange)
```markdown
---
title: Lorem Ipsum
---
```

<details><summary><code>text/turtle</code></summary>

[testmark]:# (2.6.a. assert-graph)
```turtle
@prefix ex: <http://example.org/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

[] rdfs:label "Lorem Ipsum" .
```

</details>

<details><summary><code>application/ld+json</code></summary>

[testmark]:# (2.6.a. assert-json)
```json
{
  "@context": [
    {
      "@version": 1.1,
      "dcmitype": "http://purl.org/dc/dcmitype/",
      "dcterms": "http://purl.org/dc/terms/",
      "owl": "http://www.w3.org/2002/07/owl#",
      "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
      "schema": "https://schema.org/",
      "xsd": "http://www.w3.org/2001/XMLSchema#",
      "_Dataset": {
        "@id": "dcmitype:Dataset"
      },
      "_HTML": {
        "@id": "rdf:HTML"
      },
      "_Image": {
        "@id": "dcmitype:Image"
      },
      "_Table": {
        "@id": "schema:Table"
      },
      "_Text": {
        "@id": "dcmitype:Text"
      },
      "_boolean": {
        "@id": "xsd:boolean"
      },
      "_content": {
        "@id": "rdf:value"
      },
      "_format": {
        "@id": "dcterms:format"
      },
      "_label": {
        "@id": "rdfs:label"
      },
      "_sameAs": {
        "@id": "owl:sameAs",
        "@container": "@set"
      },
      "_seeAlso": {
        "@id": "rdfs:seeAlso",
        "@container": "@set"
      }
    },
    {
      "@base": "http://example.org/",
      "@vocab": "http://example.org/terms/"
    }
  ],
  "_label": "Lorem Ipsum",
  "@graph": []
}
```

</details>
