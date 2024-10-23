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