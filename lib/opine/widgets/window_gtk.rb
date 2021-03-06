class Opine::Native::Window < Opine::Window
  def initialize(options,&block)
    @native = Gtk::Window.new

    super

    native.set_default_size frame.width, frame.height
    native.set_position :center

    native.signal_connect "destroy" do 
      Gtk.main_quit 
    end

    instance_eval(&block) if block

    native.show_all
    @visible = true # TODO: haven't found a good way to check
  end

  def title= name
    native.set_title name
  end

  def visible?
    @visible ? true : false
  end
end
