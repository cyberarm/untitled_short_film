class Film
  class Scenes
    class SceneEleven < Film::Scene
      # Boarding plane
      # and Takeoff

      def setup
        @tick = 0
        @persons = 0
        @fade_alpha= 255
        @sky_alpha = 254
        @gosu_time = $global_tick

        Film::Sun11.new(image: "assets/sun/sun.png", z: 5)
        Film::Plane11.new(image: "assets/planes/scene_05_plane.png", z: 5)
        Mother.new(image: "assets/scene_11/mother-0.png", z: 5)

        PoleMan11.new(image: "assets/scene_11/uniformed-0.png", z: 4, x: 420)
        PoleMan11.new(image: "assets/scene_11/uniformed-0.png", z: 4, x: 520)
        PoleMan11.new(image: "assets/scene_11/uniformed-0.png", z: 4, x: 620)
        Coffin11.new(image:  "assets/scene_08/coffin.png", z: 3, x: 350)

        PoleMan11.new(image: "assets/scene_11/uniformed-0.png", z: 4, x: 720)
        PoleMan11.new(image: "assets/scene_11/uniformed-0.png", z: 4, x: 820)
        PoleMan11.new(image: "assets/scene_11/uniformed-0.png", z: 4, x: 920)
        Coffin11.new(image:  "assets/scene_08/coffin.png", z: 3, x: 650)
      end

      def draw
        super
        # Background
        # Sky
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(135, 206, 235, @sky_alpha),-3)

        # Airport || Aircraft carrier
        $window.fill_rect(0,$window.height-73,$window.width,$window.height,Gosu::Color::GRAY,-1)

        # Transition (black)
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(0,0,0,@fade_alpha),5)
      end

      def update
        super
        unless (gosu_time)/1000.0 >= 5
          @fade_alpha-=5 unless @fade_alpha <= 0
        end

        if (gosu_time)/1000.0 >= 15
          @fade_alpha+=2
        end

        if (gosu_time)/1000.0 >= 20
          $window.next_scene
        end
      end
    end
  end
end

class Film
  class Plane11 < Film::Object
    def setup
      self.x = $window.width/2+100
      self.y = $window.height-370
      self.factor_x = 2
      self.factor_y = 2
      self.angle    = -4
    end
  end
end

class Film
  class Sun11 < Film::Object
    def setup
      self.x = $window.width/2
      self.y = 70
      self.factor_x = 0.7
      self.factor_y = 0.7
    end

    def update
      self.x+=0.05
      self.y-=0.05
    end
  end
end

class Film
  # TODO: Animate and change to dress uniforms
  class PoleMan11 < Film::Object
    def setup
      @gosu_time = $global_tick
      @tick = 0
      @index= 0
      self.y = $window.height-200
      self.factor_x = -0.2
      self.factor_y = 0.2

      @images = ["assets/scene_11/uniformed-0.png", "assets/scene_11/uniformed-1.png", "assets/scene_11/uniformed-2.png"]
    end

    def next_image
      @index+=1
      if @index >= @images.count
        @index = 0
        @images.reverse!
      end

      self.options[:image] = @images[@index]
      check_image_cache_then_set_image
    end

    def update
      unless (gosu_time)/1000.0 >= 9.5
        self.x-=0.25
        if @tick >= 10
          next_image
          @tick = 0
        end
      else
        # change image to standing
        self.options[:image] = "assets/scene_11/uniformed-1.png"
        check_image_cache_then_set_image
      end

      @tick+=1
    end
  end
end

class Film
  class Coffin11 < Film::Object
    def setup
      @gosu_time    = $global_tick
      self.y        = $window.height-180
      self.factor_x = 0.4
      self.factor_y = 0.4
    end

    def update
      unless (gosu_time)/1000.0 >= 9.5
        self.x-=0.25
      end
    end
  end
end

class Film
  class Mother < Film::Object
    def setup
      @gosu_time = $global_tick
      @index = 0
      self.x = 100
      self.y = $window.height-200

      self.factor_x = 0.2
      self.factor_y = 0.2
    end

    def update
      if (gosu_time)/1000.0 >= 9.0
        self.options[:image] = "assets/scene_11/mother-1.png"
        check_image_cache_then_set_image
      end
    end
  end
end
