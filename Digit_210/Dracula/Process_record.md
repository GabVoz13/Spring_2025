# Dracula Process Record

Step.1 Mark Chapters
Find:
`^CHAPTER (\w+)\s*$`
Replace:
`<chapter number="\1">\n<title>CHAPTER \1</title>`

Step.2 Mark Journal Entries
Find:
`^([\d]+ [A-Za-z]+)\.\s*`
Replace:
`\n<entry date="\1">\n`

Step.3 Mark Paragrpaphs
Find:
`\n\n+`
Replace:
`</p?\n<p>`

Step.4 Mark Quotes
Find:
`"([^"]+)"`
Replace:
`<quote>\1</quote>`

Make XML and add root element
