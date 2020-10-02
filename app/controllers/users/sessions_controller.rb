
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'static_pages_layout', only: [:new, :create]
end