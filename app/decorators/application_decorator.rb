class ApplicationDecorator < Draper::Decorator
  protected

  def current_user
    h.current_user
  end

  def logged_in?
    h.logged_in?
  end

  def t(link, options={})
    h.t(link, options)
  end
end