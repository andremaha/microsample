# Returns the full title on a per-page basis
def full_title(page_title)
  base_title = "MicroSamplt"
  unless page_title
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def log_in(user)
  visit login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
  # Log in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end