local function format_xml_string(xml_string)
  if not xml_string or type(xml_string) ~= 'string' then
    return ''
  end
  local formatted_xml = xml_string
  formatted_xml = formatted_xml:gsub('[\r\n]', '')
  formatted_xml = formatted_xml:gsub('%s+', ' ')
  formatted_xml = formatted_xml:gsub('>(%s*)<', '><')
  formatted_xml = formatted_xml:gsub('(/>)(<[%w_.:-]+[^>]*>)', '%1\n%2')
  formatted_xml = formatted_xml:gsub('(</[%w_.:-]+>)(<[%w_.:-]+[^>]*>)', '%1\n%2')
  formatted_xml = formatted_xml:gsub('^%s+', ''):gsub('%s+$', '')
  return formatted_xml
end

local function format_current_buffer_xml()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local current_content = table.concat(lines, '\n')
  local formatted_content = format_xml_string(current_content)
  vim.cmd 'new'
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = 0 })
  vim.api.nvim_set_option_value('filetype', 'xml', { buf = 0 })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted_content, '\n', { plain = true }))
  vim.notify('Formatted XML opened in new buffer!', vim.log.levels.INFO)
end

local function setup()
  vim.keymap.set('n', '<leader>fx', function()
    format_current_buffer_xml()
  end, {
    desc = 'Format XML in current buffer (Simple)',
    silent = true,
  })

  print 'XML Formatter plugin loaded! Try <leader>fx on an XML file.'
end

return { setup = setup }
