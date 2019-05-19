class Film
  class Object
    attr_accessor :options
    attr_accessor :x, :y, :z, :angle, :text, :font, :size,
                  :center_x,:center_y,:factor_x,:factor_y,
                  :color, :image, :scene, :hide
    CACHED_IMAGES = []

    def initialize(options={})
      @options = options

      @text = @options[:text] ||= ""
      @font = @options[:font] ||= "./assets/fonts/xolonium/Xolonium-Regular.ttf"
      @size = @options[:size] ||= 14
      @hide = @options[:hide] ||= false
      @angle= @options[:angle]||= 0

      @center_x = @options[:center_x] ||= 0.0 # Top left of image
      @center_y = @options[:center_y] ||= 0.0

      @factor_x = @options[:factor_x] ||= 1.0 # Default
      @factor_y = @options[:factor_y] ||= 1.0

      @color = @options[:color] ||= nil
      @image = @options[:image] ||= nil
      check_image_cache_then_set_image

      @x = @options[:x] ||= 0
      @y = @options[:y] ||= 0
      @z = @options[:z] ||= 0

      raise "'$window.active_scene' is nil!" unless $window.active_scene
      @scene = $window.active_scene
      @scene.objects << self unless @options[:manual_draw]
      setup if defined?(setup)
    end

    def draw
      if @image && @color
        @image.draw_rot(@x, @y, @z, @angle, @center_x, @center_y, @factor_x, @factor_y, @color)
      elsif @image
        @image.draw_rot(@x, @y, @z, @angle, @center_x, @center_y, @factor_x, @factor_y)
      end
    end

    def update
      # Exist. Crash Not.
    end

    def destroy
      self.scene.objects.delete(self)
    end

    def gosu_time
      ($global_tick-@gosu_time)
    end

    def check_image_cache_then_set_image
      if @image
        if CACHED_IMAGES.count <= 0
          _image = Gosu::Image.new(@options[:image])
          CACHED_IMAGES << {image: @options[:image], instance: _image}
          @image = _image
        else
          result = CACHED_IMAGES.find do |image|
            if @options[:image] == image[:image]
              @image = image[:instance]
            end
          end

          unless result
            _image = Gosu::Image.new(@options[:image])
            CACHED_IMAGES << {image: @options[:image], instance: _image}
            @image = _image
          end
        end
      end
    end
  end
end
