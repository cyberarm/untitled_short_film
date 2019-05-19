class Film
  class Scenes
    class SceneThirteen < Film::Scene
      # CONSIDER DROPPING/REMOVING SCENE

      def setup
        @gosu_time = $global_tick
        @zoom = true
        @factor = 3.0
        @fade_alpha = 0
        @white_fade_alpha = 255
        Film::FirePlace.new(image: "assets/scene_01/fireplace.png", x: $window.width, y: $window.height, z: 1)
        Film::Lamp.new(image: "assets/scene_01/lamp.png", x: $window.width, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width-400, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width-240, y: $window.height, z: 1)
        Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width-80, y: $window.height, z: 1)
        @last_frame = Film::PhotoFrame.new(image: "assets/scene_01/photoframe.png", x: $window.width+80, y: $window.height, z: 1)
      end

      def draw
        super unless @zoom
        if @zoom
          $window.scale(@factor,@factor, @last_frame.x, @last_frame.y) do
            super
          end
        end
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color::GRAY,-1)
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(255,255,255,@white_fade_alpha), 5)
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(0,0,0,@fade_alpha), 5)
      end

      def update
        @factor-=0.005 unless @factor <= 1.0
        @white_fade_alpha-=3 unless @white_fade_alpha <= 0
        $music.volume-=0.002 unless $music.volume <= 0.0

        if (gosu_time)/1000.0 >= 11.5
          @fade_alpha+=2
        end
        if (gosu_time)/1000 >= 14
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
