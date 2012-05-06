# Returns the full title on a per-page basis
def full_title(page_title)
  base_title = "MicroSample"
  unless page_title
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end