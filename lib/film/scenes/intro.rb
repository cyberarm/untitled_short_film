class Film
  class Scenes
    class Intro < Film::Scene
      def setup
        @gosu_time = $global_tick
        @transition_alpha = 0

        Film::Text.new(text: "Untitled Short Film", x: $window.width/10, y: $window.height/3, size: 100)
        Film::Text.new(text: "By Cyberarm", x: $window.width/3, y: $window.height/3+100, size: 50)
      end

      def draw
        super
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 0, @transition_alpha), 5)
      end

      def update
        super
        if (gosu_time)/1000.0 >= 2.5
            @transition_alpha+=3
        end

        if (gosu_time)/1000 >= 6
          $window.next_scene
        end
      end
    end
  end
end
