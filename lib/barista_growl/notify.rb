require 'growl'
require 'rails'
require 'barista'

module BaristaGrowl
  class Railtie < Rails::Railtie
    
    initializer "barista_growl.configure_rails_initialization" do
      Barista.on_compilation_with_warning { |path, output|
        message = "#{output.split("\n")[0]}"
        Growl.notify_warning(message) if Growl.installed?
      }
      Barista.on_compilation_error { |path, output|
        message = "#{path} failed to compile:\n\n#{output.split("\n")[0]}"
        Growl.notify_error(message) if Growl.installed?
      }
    end

  end
end