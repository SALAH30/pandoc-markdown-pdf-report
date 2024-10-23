function Table(el)
  function convert_cell(cell)
    local convert
    local content = {}
    for k1,element in pairs(cell) do
      convert = false
      if element.tag == "Plain" then
        for k2, inline in pairs(element.content) do
          if inline.tag == "RawInline" and inline.text == "<br>" and inline.format == "html" then
            convert = true
            inline.format = "tex"
            inline.text = "\\\\"
          end          
        end
      end

      if convert then
        inlines = {}
        inlines[#inlines + 1] = pandoc.RawInline("tex", "\\pbox[t]{\\textwidth}{")
        for k2, inline in pairs(element.content) do
          inlines[#inlines + 1] = inline
        end
        inlines[#inlines + 1] = pandoc.RawInline("tex", "}")
        element = pandoc.Plain(inlines)
      end
      content[k1] = element

    end
    return content
  end

  function convert_row(row)
    local new_row = {}
    for k, cell in pairs(row) do
      new_row[k] = convert_cell(cell)
    end
    return new_row
  end
end

