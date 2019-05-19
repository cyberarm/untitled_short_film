class Film
  class Scenes
    class Credits < Film::Scene
      def setup

        $music.stop
        $music = Gosu::Song.new("assets/music/june-27-2015-brass-segment-credits_section.ogg")
        $music.play

        @positions_set = false

        Film::Credit.new(text: "Untitled Short Film", size: 100)
        Film::Credit.new(text: "", size: 40)
        Film::Credit.new(text: "Created By", size: 40)
        Film::Credit.new(text: "Cyberarm - cyberarm.github.io", size: 40)
        Film::Credit.new(text: "", size: 40)

        Film::Credit.new(text: "Created With", size: 40)
        Film::Credit.new(text: "Gosu - libgosu.org", size: 40)
        Film::Credit.new(text: "GNU Image Manipulation Program - gimp.org", size: 40)
        Film::Credit.new(text: "Open Broadcast Software - obsproject.com", size: 40)
        Film::Credit.new(text: "Atom - atom.io", size: 40)
        Film::Credit.new(text: "", size: 40)

        Film::Credit.new(text: "Asset Sources", size: 40)
        Film::Credit.new(text: "OpenGameArt - opengameart.org", size: 40)
        Film::Credit.new(text: "OpenClipArt - openclipart.org", size: 40)
        Film::Credit.new(text: "", size: $window.height+40) # Push 'thanks for watching', down a ways.

        Film::Credit.new(text: "Thanks For Watching.", size: 75)

        set_positions unless @positions_set
      end

      def update
        super
        $window.scene_original if (self.objects.last.y <= -Film::Credit::N.last) && !$music.playing?
      end

      def set_positions
        last_y = 0
        self.objects.each do |object|
          next unless object.is_a?(Film::Credit)
          object.y = $window.height+last_y
          last_y+=object.size
        end
        @positions_set = true
      end
    end
  end
end

class Film
  class Credit < Film::Text
    N = []
    def setup
      super
      N << @size
      @x = $window.width/6
      @scroll_speed = 1.55
    end

    def update
      self.y-=@scroll_speed
    end
  end
end
