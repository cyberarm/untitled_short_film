class Film
  class Scenes
    class SceneSeven < Film::Scene
      # Death scene

      def setup
        $music = Gosu::Song.new("assets/music/august-31-2015.ogg")
        $music.play

        @gosu_time = $global_tick
        @tick = 0
        @last_jumper = -1024
        @jumpers     = 0
        @fade_alpha  = 255
        @done = false

        @sky_color = Gosu::Color.rgba(0, 0, 25, 254)
        @flash_color = Gosu::Color.rgba(255, 255, 100, 100)
        @background_color = Gosu::Color.rgba(0, 0, 25, 254)
        @color_z = -2

        8.times do
          @last_jumper+=rand(100..150)
          Film::Person07.new(image: "assets/scene_05/person.png", y: 0, x: @last_jumper)
          @jumpers+=1
          @tick = 0
        end

        Film::Tree07.new(image: "assets/scene_07/tree.png", y: 35)
        Film::Tree07.new(image: "assets/scene_07/tree.png", x: $window.width-400, y: 400, z: -1, factor_x: 0.5, factor_y: 0.5)
        Film::Tree07.new(image: "assets/scene_07/tree.png", x: $window.width/2, y: 400, z: -1, factor_x: -0.5, factor_y: 0.5)
      end

      def draw
        super
        # Sky background
        $window.fill_rect(0,0, $window.width,$window.height, @sky_color, -3)
        $window.fill_rect(0,0, $window.width,$window.height, @background_color, @color_z)

        # Fade out
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 0, @fade_alpha), 10)

        # Grassy ground
        $window.fill_rect(0,$window.height-50, $window.width,$window.height, Gosu::Color.rgba(12, 149, 25, 254), -1)
      end

      def update
        super
        @tick+=1

        @fade_alpha-=5 if @fade_alpha >= 0 && gosu_time/1000.0 <= 5
        if (gosu_time/1000.0).between?(13.0, 13.05)
          @objects[6..7].each do |object|
            object.drop
          end
        end

        if (gosu_time/1000.0).between?(12.9,13.0)
          @background_color = @flash_color
          @color_z = 1
        end
        if (gosu_time/1000.0).between?(13.15,13.18)
          @background_color = @sky_color
          @color_z = -2
        end
        if (gosu_time/1000.0).between?(13.2,13.3)
          @background_color = @flash_color
          @color_z = 1
        end
        if (gosu_time/1000.0).between?(13.4,13.5)
          @background_color = @sky_color
          @color_z = -2
        end

        if (gosu_time/1000.0) >= 13.0
          @objects.each(&:freeze)
        end


        @fade_alpha+=2.5 if gosu_time/1000.0 >= 13
        $window.next_scene if gosu_time/1000.0 >= 17
      end
    end
  end
end

class Film::Tree07 < Film::Object
  def setup
  end
end

class Film::Person07 < Film::Object
  def setup
    @gosu_time = $global_tick
    @tick = 0
    @move = true
    @dead = false
    @changed = false
    self.factor_x = 0.25
    self.factor_y = 0.25
    self.center_y = 0.5

    self.y = $window.height-(@image.height/8)

    @images = ["assets/scene_03/person_0.png",
              "assets/scene_03/person_1.png",
              "assets/scene_03/person_2.png",
              "assets/scene_03/person_1.png"]
    @current_image = rand(0..@images.count)
    next_image
  end

  def next_image
    @current_image = 0 if @current_image >= @images.count

    self.options[:image] = @images[@current_image]
    check_image_cache_then_set_image
    @current_image+=1
  end

  def update
    @tick+=1
    self.x+=0.8 if @move

    if @move && @tick >= rand(10..15)
      next_image
      @tick = 0
    end
  end

  def freeze
    unless @dead
      if @move == false && @changed == false
        @changed = true

        n = rand(0..7)
        if n.between?(0, 3)
          self.factor_x = -self.factor_x
        end

        self.options[:image] = "assets/scene_07/kneeling.png"
        check_image_cache_then_set_image
      else
        @move = false
      end
    end
  end

  def drop
    @dead = true
    @move = false
    self.angle = rand(80.0..92.3)
    self.center_y = 1.0
    self.y+=7
    self.options[:image] = "assets/scene_03/person_1.png"
    check_image_cache_then_set_image
  end
end
