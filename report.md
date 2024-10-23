# Generate a nice-looking reports with Markdown and Pandoc

I wanted to write about this since a while, and here it is ! 
How to generate a nice-looking reports with markdown and pandoc. 
And before we dive in, lets start with having a look about these two tools and what they are used for !

Markdown and Pandoc are two powerful tools that make writing and formatting reports efficient and traightforward. 
By using Markdown to structure content and Pandoc to convert it into various formats like PDF, HTML, or DOCX, you can maintain flexibility while keeping your workflow lightweight and efficient.

Here, I will go through the steps to write a report using Markdown and convert it to different formats using Pandoc.

# What is Markdown?

Markdown is a simple markup language that makes it easy to format plain text. 
It is widely used because of its readability, and it allows you to create headers, lists, links, code blocks, tables, and more with minimal syntax.
It is popular among developers, Github for exemple uses use Markdown for project documentation, and converts markdown to HTML directly.

If you want to use Markdwon as document format and need the output as a pdf HTML or even DOCX ? In this case you need a tool that make that conversion for you. 
And that bring us to Pandoc.

# What is Pandoc?

Pandoc is a universal document converter that allows you to convert files from one format to another. 
With Pandoc, you can convert a Markdown file into a PDF, HTML, DOCX, LaTeX, and many other formats. 
It's highly customizable and supports a range of formatting and template options.

# Write a Report with Markdown and Pandoc

## Prerequisites

Before you begin, make sure you have Pandoc installed. 
You can download Pandoc from [Pandoc’s official website](https://pandoc.org/installing.html). 
Follow the instructions for your operating system.

On debian/Ubuntu system, you can install it by downloading [pandoc](https://github.com/jgm/pandoc/releases/), then using the bash command:

~~~console
# dpkg -i $DEB
~~~

where `$DEB` is the path to the downloaded debian package.

You need *rsvg-convert* if you have some svg files you want to convert them to pdf:

~~~console
# apt install librsvg2-bin
~~~

You can also install the LaTeX eco-system, pandoc can convert latex from your markdown file.

~~~console
# apt install texlive-latex-base
# apt install texlive-lang-english texlive-latex-extra latexmk
# apt install texlive-fonts-recommended texlive-fonts-extra
~~~

Finally, you can download some filters for the *pandoc* system:

~~~console
$ pip install pandoc-latex-admonition
~~~

## Markdown Structure

Start by writing the report in a plain text editor like Visual Studio Code, Sublime Text, or even a basic text editor like Notepad.

Here’s a basic structure for your Markdown report:

### Headers

Use `#` to define a header, `##` to define a subheader, `###` to define a subsubheader, etc.
This will help you to structure your report efficiently.

### Lists

- Use `-` to define a list item.
  - Use `-` to define a sublist item.
- Use `*` to define a list item.
- Use `+` to define a list item.
  - You can also nest lists.
  - like this

### Tables

| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Item 1   | Item 2   | Item 3   |
| Item 4   | Item 5   | Item 6   |

### Code Blocks

you can use code blocks to display code.

```python
print("Hello, World!")
```
replace the language with the language of the code you are writing.
for example:

```bash
ls -al
```

or

```javascript
console.log("Hello, World!");
```

### Styled text and Links 

You can also add **bold** text, *italic* text, and links like [this one](https://example.com).


### Images

use this syntax to add an image to your report: `![Aneo image](images/aneo.png)`

![Aneo image](images/aneo.png)

### Footnotes

Here's a simple footnote[^1].

[^1]: This is the footnote content.



## Convert Markdown to PDF or DOCX with Pandoc

Once you’ve finished writing your report in Markdown, you can use Pandoc to convert it into a PDF, Word document (DOCX), or any other format. For example, to convert the Markdown file (`report.md`) into a PDF, use the following command:

```bash
pandoc report.md -o report.pdf
```

If you want to convert it to a DOCX file, use:

```bash
pandoc report.md -o report.docx
```

## Customizing The Output

Pandoc allows you to customize the output of your document. Here are some useful flags:

- Specify a template for your document (e.g., LaTeX template for PDFs):

```bash
pandoc report.md -o report.pdf --template=mytemplate.tex
```

- Add metadata like title and author directly from the command line:

```bash
pandoc report.md -o report.pdf --metadata title="My Report" --metadata author="Your Name"
```

- Include citations and bibliographies by adding a bibliography file:

```bash
pandoc report.md --citeproc --bibliography references.bib -o report.pdf
```

## Advanced Features

### Filters

Pandoc allows you to use lua filters to customize the output of your document.

```bash
pandoc report.md -o report.pdf --lua-filter table.lua
```


This will apply the table.lua filter to your document.

For example, you can use the following lua filter to make fisrt level headers uppercase:

```lua
function Header(el)
  if el.level == 1 then
    local new_content = {}
    for _, inline in ipairs(el.content) do
      if inline.t == "Str" then
        inline.text = string.upper(inline.text)
      end
      table.insert(new_content, inline)
    end
    el.content = new_content
    return el
  end
end
```

Check the `table.lua` file for more.

# Project structure

## Make

Naviate to the root run the following command:

~~~console
$ make
~~~

A pdf called `build/report.pdf` will be created.

## Update the report

- To update the report, you need to update the markdown file `report.md`.
- You can also udpate the `title.md`, `metadata.yaml` or `Makefile`.
- Then, generate the pdf with `make` command.

## Github Actions

You can use GitHub Actions to generate the pdf.

# Conclusion

Writing a report using Markdown and Pandoc is efficient, lightweight, and highly flexible. With Markdown, you can focus on content without getting bogged down by formatting, and with Pandoc, you can easily convert that content into polished documents like PDFs, Word documents, or even web pages. By mastering these tools, you’ll be able to create professional reports quickly and easily.

Happy writing!