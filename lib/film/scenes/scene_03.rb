class Film
  class Scenes
    class SceneThree < Film::Scene
      # Boarding plane
      # and Takeoff

      def setup
        @tick = 0
        @persons = 0
        @fade_alpha= 255
        @gosu_time = $global_tick

        Film::Plane03.new(image: "assets/planes/scene_05_plane.png", z: 5)
      end

      def draw
        super
        # Background
        # Sky
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(0, 0, 25, 254),-3)
        # Water
        $window.fill_rect(0,$window.height-50,$window.width,$window.height,Gosu::Color.rgba(0, 0, 122, 250),-2)

        # Airport || Aircraft carrier
        $window.fill_rect(0,$window.height-73,$window.width-100,$window.height,Gosu::Color::GRAY,-1)

        # Transition (black)
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(0,0,0,@fade_alpha),5)
      end

      def update
        super
        unless (gosu_time)/1000.0 >= 5
          @fade_alpha-=5 unless @fade_alpha <= 0
        end

        if (gosu_time)/1000.0 >= 18
          @fade_alpha+=2
        end

        if (gosu_time)/1000.0 >= 21
          $window.next_scene
        end

        if @tick >= 30 && @persons < 8
          Film::Person03.new(image: "assets/scene_03/person_0.png", x: 0, y: $window.height+100)
          @persons+=1
          @tick = 0
        else
          @tick+=1
        end
      end
    end
  end
end

class Film
  class Plane03 < Film::Object
    def setup
      @gosu_time = $global_tick
      self.x = $window.width/4*3/2*1
      self.y = $window.height-@image.height+25
    end

    def update
      # Wait until Jumpers are boarded then move down runway and rotate up and lift off
      if (gosu_time)/1000.0 >= 9
        self.x+=1.3
        self.angle-=0.03
      end
      if (gosu_time)/1000.0 >= 11
        self.y-=0.2
      end
    end
  end
end

class Film
  class Person03 < Film::Object
    def setup
      @tick = 0
      @gosu_time = $global_tick

      self.center_x = 1.0
      # self.center_y = -1.0
      self.y-=250
      self.factor_x = 0.1
      self.factor_y = 0.1

      @images = ["assets/scene_03/person_0.png",
                "assets/scene_03/person_1.png",
                "assets/scene_03/person_2.png",
                "assets/scene_03/person_1.png"]
      @current_image = rand(0..@images.count)
    end

    def next_image
      @current_image = 0 if @current_image >= @images.count

      self.options[:image] = @images[@current_image]
      check_image_cache_then_set_image
      @current_image+=1
    end

    def update
      if @tick >= 10
        next_image
        @tick = 0
      end

      if (gosu_time)/1000.0 >= 4.4
        self.destroy
      end

      self.x+=2.0

      @tick+=1
    end
  end
end
