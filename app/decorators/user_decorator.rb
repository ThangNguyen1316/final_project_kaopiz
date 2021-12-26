# frozen_string_literal: true

module UserDecorator
  def display_name
    profile&.nickname || self.email.split('@').first
  end
end
