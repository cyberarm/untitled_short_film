class Film
  class Scenes
    class SceneTen < Film::Scene
      # Boarding plane
      # and Takeoff

      def setup
        @tick = 0
        @persons = 0
        @fade_alpha= 255
        @sky_alpha = 254
        @gosu_time = $global_tick

        Film::Plane10.new(image: "assets/planes/scene_05_plane.png", z: 5)
        Film::Sun10.new(image: "assets/sun/sun.png", z: -1)
      end

      def draw
        super
        # Background
        # Sky
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(255, 165, 0, @sky_alpha),-3)

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

        if (gosu_time)/1000.0 >= 18
          $window.next_scene
        end
      end
    end
  end
end

class Film
  class Plane10 < Film::Object
    def setup
      @gosu_time = $global_tick
      @speed = 1.3
      self.x = $window.width+image.width
      self.y = $window.height-321
      self.factor_x = -1.0
    end

    def update
      # Wait until Jumpers are boarded then move down runway and rotate up and lift off
      if (gosu_time)/1000.0 <= 14
        self.x-=@speed
      end
      if (gosu_time)/1000.0 <= 8
        self.angle+=0.01
      end
      if (gosu_time)/1000.0 <= 8.5
        self.y+=0.2
      else
        @speed-=0.003 unless @speed <= 0.0
      end
    end
  end
end

class Film
  class Sun10 < Film::Object
    def setup
      self.x = $window.width/2-(image.width/2)
      self.y = $window.height
    end

    def update
      self.y-=0.4
    end
  end
end
