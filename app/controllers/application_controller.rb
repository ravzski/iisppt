class ApplicationController < ActionController::Base

  layout 'application'

  def index
    render text: "", layout: true
  end

end
