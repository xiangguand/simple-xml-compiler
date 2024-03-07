# Simple-XML Compiler in C++, Rust and C#


***Create a console application with the following specifications (see the templates below to get a better idea of what the project looks like):***

- Input: an XML string (at least one character)
    - The XML string should be passed as the first command line argument.
- Output: `Valid` if given XML is valid, otherwise `Invalid` with a new line
    - Use standard output.

A string is a valid XML string if it satisfies the following two rules:

- Each starting element must have a corresponding ending element.
- Elements must be well nested, which means that the element which starts first must end last. For example, `<tutorial><topic>XML</topic></tutorial>` is considered correct, while `<tutorial><topic>XML</tutorial></topic>` is not.

To simplify the question, we treat a pair of an opening tag and a closing tag as matched only if the strings in both tags are identical. So we don’t need to parse extra components like attributes in the XML tag. For example, we treat`<tutorial date="01/01/2000">XML</tutorial>` as not correctly closed since the string `tutorial date=”01/01/2000”` in the opening tag is different from the string **tutorial** in the closing tag



