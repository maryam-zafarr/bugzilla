# frozen_string_literal: true

# Class to perform index action for home
class HomeController < ApplicationController
  skip_before_action :authenticate_user!
end
