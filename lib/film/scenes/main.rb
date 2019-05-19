class Film
  class Scenes
    class Main < Film::Scene
      def setup
        # Preload?
        $music = Gosu::Song.new($window, "assets/music/feb-17-2015-C_harp-Guitar.ogg")
        $music.play
        $music.pause
        $music.volume = 1.0

        $window.show_cursor = true unless $window.fullscreen?
        Film::Text.new(text: "Untitled Short Film", x: 50, y: 50, size: 120)
        Film::Text.new(text: "Play Press <Space>", x: $window.width/2-160/2, y: $window.height/4, size: 60)
        Film::Text.new(text: "Exit Press <Escape>", x: $window.width/2-160/2, y: $window.height/4+60, size: 60)
        @tick  = 0
        @up = true
        # @color = Gosu::Color.rgba(255,146,5,@tick)
        @color = Gosu::Color.rgba(rand(0..255),rand(0..255),rand(0..255),@tick)
      end

      def draw
        super
        $window.fill_rect(0, 0, $window.width, $window.height, @color, -1)
        $window.fill_rect($window.width/2-160/2, $window.height/4,
                          140, 160, Gosu::Color::BLACK, -1)
      end

      def update
        @tick+=1 if @up
        @tick-=1 unless @up

        if button_down?(Gosu::KbSpace)
          $window.show_cursor = false
          $music.play
          $window.next_scene
        elsif button_down?(Gosu::KbEscape)
          exit
        end

        @color.alpha = @tick
        @up = false if @tick >= 60*2.5
        @up = true if @tick <= 50
      end
    end
  end
end
