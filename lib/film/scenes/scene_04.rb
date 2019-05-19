class Film
  class Scenes
    class SceneFour < Film::Scene
      def setup
        @tick = 0
        @transition_alpha = 0
        @gosu_time = $global_tick

        Film::Sun.new(image: "assets/sun/sun.png", x: $window.width-256, y: 256, color: Gosu::Color::YELLOW)
        Film::Moon.new(image: "assets/moon/moon_2.png", x: $window.width+256*2, y: 256, color: Gosu::Color::WHITE)
        Film::Plane.new(image: "assets/planes/scene_05_plane.png", x: -256/2, y: 256)
      end

      def draw
        super
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 25, 254), -2)
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 0, @transition_alpha), 5) # Trastition
      end

      def update
        super
        @tick+=1
        if @tick >= 16
          num = rand(0..90)
          cloud = "00#{num}" if num >= 10
          cloud = "000#{num}" unless num >= 10
          Film::Cloud.new(image: "assets/smoke/#{cloud}.png", x: $window.width+256, y: rand($window.height/2..$window.height), angle: rand(0..360))
          @tick = 0
        end

        if self.objects.count >= 150
          self.objects[0..50].each do |object|
            if object.is_a?(Film::Cloud)
              self.objects.delete(object)
            end
          end
        end

        # Moon is eclipsing the Sun
        if ((gosu_time)/1000.0).between?(31, 35)
          @transition_alpha+=1.2
        end

        if ((gosu_time)/1000) >= 36
          $window.next_scene
        end
      end
    end
  end
end

# Stubs- Lazy
class Film
  class Cloud < Film::Object
    def setup
      self.center_x = 0.5
      self.center_y = 0.5

      factor = rand(1.0..2.5)
      self.factor_x = factor
      self.factor_y = factor

      @speed = rand(1.0..3.0)
    end

    def update
      super
      self.x-=@speed
    end
  end
end

class Film
  class Sun < Film::Object
    def setup
      self.center_x = 0.5
      self.center_y = 0.5

      # self.factor_x = 2
      # self.factor_y = 2
      self.angle    = 5
    end
  end
end

class Film
  class Moon < Film::Object
    def setup
      @gosu_time = $global_tick
      self.center_x = 0.5
      self.center_y = 0.5

      self.factor_x = 1.1
      self.factor_y = 1.1

      self.angle    = 5
    end

    def update
      if ((gosu_time)/1000) >= 20# TODO: Music timing
        self.x-=0.9
      end
      if ((gosu_time)/1000) >= 34# TODO: Music timing
        self.y+=0.4
      end
    end
  end
end


class Film
  class Plane < Film::Object
    def setup
      self.center_x = 0.5
      self.center_y = 0.5
    end

    def update
      self.x+=0.4
    end
  end
end
