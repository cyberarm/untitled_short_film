class Film
  class Scenes
    class SceneOne < Film::Scene
      def setup
        @gosu_time = $global_tick
        @zoom = false
        @factor = 1.0
        @fade_alpha = 0
        Film::FirePlace.new(image: "assets/scene_01/fireplace.png", x: $window.width, y: $window.height, z: 1)
        Film::Lamp.new(image: "assets/scene_01/lamp.png", x: $window.width, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width-400, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width-240, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width-80, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width+80, y: $window.height, z: 1)
      end

      def draw
        super unless @zoom
        if @zoom
          $window.scale(@factor,@factor, self.objects.last.x+90, self.objects.last.y) do
            super
          end
        end
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color::GRAY,-1)
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(255,255,255,@fade_alpha), 5)
      end

      def update
        if (gosu_time)/1000.0 >= 1.5
          @zoom = true
          @factor+=0.005
        end
        if (gosu_time)/1000.0 >= 8
          @fade_alpha+=2
        end
        if (gosu_time)/1000 >= 11
          $window.next_scene
        end
      end
    end
  end
end

# Lazy... Or maybe this way is just easier... hmm.
class Film
  class FirePlace < Film::Object
    def setup
      @x-=@image.width
      @y-=@image.height
    end
  end
end

class Film
  class Lamp < Film::Object
    def setup
      self.factor_x = 0.5
      self.factor_y = 0.5
      @x-=@image.width
      @y-=@image.height*6.3
    end
  end
end

class Film
  class PhotoFrame < Film::Object
    def setup
      self.factor_x = 0.5
      self.factor_y = 0.5
      @x-=@image.width
      @y-=@image.height*2
    end
  end
end
