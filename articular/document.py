'''
Create JSON-LD representations of Markdown content.
'''


import json

from articular.template import Template
from pathlib import Path
from pyld import jsonld
from typing import Dict


class Document:
    '''
    Make a JSON-LD representation.

        >>> md = """
        ... ---
        ... context:
        ...   Book: https://schema.org/Book
        ... ---
        ... # [Tortilla Flat](http://www.wikidata.org/entity/Q606720 "Book")
        ... """

        >>> document = Document(md)
        >>> print(document)
        {
            "@context": [
                "https://edwardanderson.github.io/articular/ns/v1/articular.json",
                {
                    "Book": "https://schema.org/Book"
                }
            ],
            "_label": "Tortilla Flat",
            "type": "Book",
            "_same_as": {
                "id": "http://www.wikidata.org/entity/Q606720",
                "type": "Book",
                "_label": "Tortilla Flat"
            }
        }

    Provide a cached context so that user employment of ontology terms
    are de-duplicated. Note how in this example there is no `birthPlace`
    key in the generated document's context.

        >>> context = {
        ...     'https://schema.org/docs/jsonldcontext.json': {
        ...         '@context': {
        ...             'birthPlace': {'@id': 'https://schema.org/birthPlace'}
        ...         }
        ...     }
        ... }

        >>> md = """
        ... ---
        ... context: https://schema.org/docs/jsonldcontext.json
        ... ---
        ... # Alfred Hitchcock
        ... * birthPlace
        ...   * Leytonstone
        ... """

        >>> document = Document(md, uri='alfred-hitchcock', context=context)
        >>> print(document)
        {
            "@context": [
                "https://edwardanderson.github.io/articular/ns/v1/articular.json",
                "https://schema.org/docs/jsonldcontext.json",
                {
                    "@base": "alfred-hitchcock#"
                }
            ],
            "id": "alfred-hitchcock",
            "_label": "Alfred Hitchcock",
            "birthPlace": {
                "_label": "Leytonstone"
            }
        }

    '''

    def __init__(self, markdown: str, uri: str = None, context: Dict = None, vocab: str = None) -> None:
        content = Template.transform(markdown)
        user_contexts = content.pop('@context')
        try:
            self.remote_context_keys = [i for i in user_contexts if isinstance(i, str)]
        except TypeError:
            self.remote_context_keys = list()

        clean_context = self._deduplicate_context(user_contexts, context)
        # Keep `id` at the top of the document.
        self.document = {'@context' : clean_context}
        if uri:
            self.document['id'] = uri
            base = f'{uri}#'
            try:
                self.document['@context'][-1]['@base'] = base
            except:
                self.document['@context'].append({'@base': base})

        if vocab:
            try:
                if '@vocab' not in self.document['@context'][-1]:
                    self.document['@context'][-1]['@vocab'] = vocab
            except:
                self.document['@context'].append({'@vocab': vocab})


        self.document.update(content)

    def __str__(self) -> str:
        return Template._dump(self.document)

    def _deduplicate_context(self, user_context: Dict, context: Dict) -> Dict:
        '''
        Remove keys from user context which are specified in the given context.
        '''
        # Aggregate remote contexts.
        remote_context = dict()
        if context:
            for key in self.remote_context_keys:
                if key in context:
                    remote_context.update(context[key]['@context'])

        # Remove unwanted keys.
        for item in user_context:
            if isinstance(item, dict):
                for key in dict(item):
                    # Remove user-duplicated key.
                    if key in remote_context:
                        item.pop(key)
                    # Remove user-defined key.
                    try:
                        value = item[key]
                        if value.startswith('user:'):
                            item.pop(key)
                    except Exception:
                        pass

        # Remove empty contexts.
        for item in list(user_context):
            if not item:
                user_context.remove(item)

        # TODO: Deduplicate keys if @id is in ontology too.

        return user_context

    @property
    def framed(self):
        '''
        Refer to <https://json-ld.org/spec/latest/json-ld-framing/#framing>.
        '''
        context = self.document['@context']
        context_path = Path(__file__).parent.parent.joinpath('docs/ns/v1/articular.json')
        with open(context_path, 'r') as in_file:
            ctx = json.load(in_file)

        context[0] = ctx['@context']
        frame = {
            '@context': context,
            '@embed': '@always',
            '@id': self.document['id']
        }
        framed = jsonld.frame(self.document, frame)
        framed['@context'][0] = 'https://edwardanderson.github.io/articular/ns/v1/articular.json'
        return Template._dump(framed)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
