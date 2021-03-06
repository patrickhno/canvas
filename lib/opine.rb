
require 'active_support/core_ext/module/delegation'
require 'active_support/inflector'

module Opine
  def self.platform
    @platform ||= case RUBY_PLATFORM
    when /darwin/
      :osx
    when /linux/
      :gtk
    when /win/
      :win
    end
  end
end

case Opine.platform
when :osx
  require 'cocoa'
when :win
  require 'stench'
when :gtk
  require 'gir_ffi-gtk3'
end
require 'cairo'

module Opine::Native; end
module Opine::Dark; end

require 'opine/rect'

require 'opine/widget'
[:application, :alert, :view, :window, :table].each do |widget|
  [:native, :dark].each do |theme|
    [
      "#{widget}",
      "#{widget}_#{Opine.platform}",
      "#{widget}_#{theme}",
      "#{widget}_#{theme}_#{Opine.platform}"
    ].each do |name|
      require "opine/widgets/#{name}" if File.exists?(File.dirname(__FILE__) + "/opine/widgets/#{name}.rb")
    end
  end
end
