'''
Command line interface.
'''


import frontmatter

from argparse import ArgumentParser
from articular.document import Document
from pathlib import Path
from requests import Session
from rdflib import Graph
from rich import print_json


def main():
    parser = ArgumentParser()
    parser.add_argument(
        'files',
        nargs='+',
        type=Path,
        help=''
    )
    parser.add_argument(
        '--base',
        type=str
    )
    parser.add_argument(
        '--format',
        type=str,
        default='json'
    )
    args = parser.parse_args()

    session = Session()
    cached_contexts = dict()

    for path in args.files:
        with open(path, 'r') as in_file:
            markdown = in_file.read()

        location = str(path.parent.joinpath(path.stem))
        if args.base:
            uri = args.base + location
        else:
            uri = location

        # Cache remote context.
        front_matter, _ = frontmatter.parse(markdown)
        front_matter_context = front_matter.get('context')
        if isinstance(front_matter_context, str):
            if front_matter_context not in cached_contexts:
                try:
                    response = session.get(front_matter_context)
                except Exception:
                    continue
                context = response.json()
                cached_contexts[front_matter_context] = context

        document = Document(markdown, uri=uri, context=cached_contexts)

        if args.format == 'json':
            print_json(str(document))
        else:
            # Serialise RDF.
            graph = Graph()
            graph.parse(data=str(document), format='json-ld')
            serialisation = graph.serialize(format=args.format)
            print(serialisation)


if __name__ == '__main__':
    main()