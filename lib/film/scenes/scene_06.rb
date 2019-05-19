class Film
  class Scenes
    class SceneSix < Film::Scene
      # Jumpers landing. land, move right. fade out.

      def setup
        @gosu_time = $global_tick
        @tick = 0
        @last_jumper = 0
        @jumpers     = 0
        @fade_alpha  = 255
      end

      def draw
        super
        # Sky background
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 25, 254), -2)

        # Fade out
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 0, @fade_alpha), 10)

        # Grassy ground
        $window.fill_rect(0,$window.height-50, $window.width,$window.height, Gosu::Color.rgba(12, 149, 25, 254), -1)
      end

      def update
        super
        @tick+=1

        @fade_alpha-=5 if @fade_alpha >= 0 && (gosu_time)/1000.0 <= 5
        @fade_alpha+=2 if (gosu_time)/1000.0 >= 20

        $window.next_scene if (gosu_time)/1000.0 >= 23

        if @tick >= 18 && @jumpers < 8
          Film::Jumper06.new(image: "assets/scene_05/person.png", y: 0, x: @last_jumper+=200)
          @jumpers+=1
          @last_jumper = 100 if @jumpers == 4
          @tick = 0
        end
      end
    end
  end
end

class Film::Jumper06 < Film::Object
  def setup
    @gosu_time = $global_tick
    @tick = 0
    @landed = false
    self.factor_x = 0.5
    self.factor_y = 0.5
    self.center_y = 0.75

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
    @tick+=1

    if self.y >= $window.height-25
      @landed = true unless @landed == :set

      if @landed && @landed != :set
        self.factor_x = 0.25
        self.factor_y = 0.25
        self.center_y = 1.0
        @landed = :set
      end

      if @tick >= 15
        next_image
        @tick = 0
      end

      self.x+=2
    else
      self.y+=1
    end
  end
end
