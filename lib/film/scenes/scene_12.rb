class Film
  class Scenes
    class SceneTwelve < Film::Scene
      # CONSIDER DROPPING/REMOVING SCENE

      def setup
        @fade_alpha= 255
        @gosu_time = $global_tick
        Film::Photo.new(image: "assets/scene_12/grave.png", x: $window.width/2-420, y: $window.height-701)
        Film::Photo.new(image: "assets/scene_12/grave.png", x: $window.width/2, y: $window.height-701)
      end

      def draw
        super
        # Background
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color::WHITE,-1)

        # Transition
        $window.fill_rect(0,0,$window.width,$window.height,Gosu::Color.rgba(255,255,255,@fade_alpha),5)
      end

      def update
        unless (gosu_time)/1000.0 >= 5
          @fade_alpha-=5 unless @fade_alpha <= 0
        end

        if (gosu_time)/1000.0 >= 5
          @fade_alpha+=2
        end

        if (gosu_time)/1000.0 >= 8
          $window.next_scene
        end
      end
    end
  end
end
