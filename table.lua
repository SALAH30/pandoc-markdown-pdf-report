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

  -- if FORMAT == "latex" then
  --   local rows = {}

  --   for k,row in pairs(el.rows) do
  --       rows[k] = convert_row(row)
  --   end
  --   return pandoc.Table(el.caption, el.aligns, el.widths, el.headers, rows)
  -- end
  if FORMAT == "latex" and el and el.rows then
    local rows = {}
    for k, row in pairs(el.rows) do
      rows[k] = convert_row(row)
    end
    return pandoc.Table(el.caption, el.aligns, el.widths, el.headers, rows)
  elseif FORMAT == "latex" then
    -- Log an error or handle the case where the table doesn't have the expected structure
    io.stderr:write("Warning: Table doesn't have the expected structure\n")
    return el
  end
end

