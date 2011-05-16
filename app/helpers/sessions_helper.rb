module SessionsHelper
  def memorized?
    return "value='1' checked" if cookies[:remember_me]
    "value='0' unchecked"
  end
end
