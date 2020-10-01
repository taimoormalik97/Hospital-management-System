# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'static_pages_layout', only: [:new]
end