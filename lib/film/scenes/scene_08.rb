class Film
  class Scenes
    class SceneEight < Film::Scene
      def setup
        # $music = Gosu::Song.new($window, "assets/music/june-27-2015-brass-segment.ogg")
        # $music.play

        @gosu_time = $global_tick
        @sky_color = Gosu::Color.rgba(0, 50, 100, 254)
        @ground_color = Gosu::Color.rgba(200, 200, 200, 254)
        @fade_color   = Gosu::Color.rgba(0, 0, 0, 0)

        Coffin08.new(image: "assets/scene_08/coffin.png", x: -300, y: $window.height-204, factor_x: 0.35, factor_y: 0.35)
        Film::Person08.new(image: "assets/scene_03/person_0.png", x: -300)
        Film::Person08.new(image: "assets/scene_03/person_0.png", x: 80-300)
        Film::Person08.new(image: "assets/scene_03/person_0.png", x: 150-300)

        Coffin08.new(image: "assets/scene_08/coffin.png", x: 10, y: $window.height-204, factor_x: 0.35, factor_y: 0.35)
        Film::Person08.new(image: "assets/scene_03/person_0.png")
        Film::Person08.new(image: "assets/scene_03/person_0.png", x: 80)
        Film::Person08.new(image: "assets/scene_03/person_0.png", x: 150)

        Plane08.new(image: "assets/planes/scene_05_plane.png", x: 500, y: $window.height-400, factor_x: 2, factor_y: 2, angle: -4)
      end

      def draw
        super
        $window.fill_rect(0,0,$window.width,$window.height, @fade_color, 10)
        $window.fill_rect(0,0,$window.width,$window.height, @sky_color, -3)
        $window.fill_rect(0,$window.height-105,$window.width,$window.height, @ground_color, -1)
      end

      def update
        super
        if gosu_time/1000.0 >= 28
          @fade_color.alpha+=2.2
        end

        if gosu_time/1000.0 >= 32
          $window.next_scene
        end
      end
    end
  end
end

class Film::Coffin08 < Film::Object
  def setup
    @gosu_time = $global_tick
  end

  def update
    super
    self.x+=0.8

    if self.x >= 510
      self.destroy
    end
  end
end

class Film::Plane08 < Film::Object
  def setup
    @gosu_time = $global_tick
  end

  def update
    super
    if (gosu_time)/1000.0 >= 20
      self.x+=1
    end
    if (gosu_time)/1000.0 >= 24.6
      self.y-=0.41
      self.angle-=0.04
    end
  end
end

class Film::Person08 < Film::Object
  def setup
    @gosu_time = $global_tick
    @tick = 0
    @move = true
    self.factor_x = 0.20
    self.factor_y = 0.20
    self.center_y = 0.5

    self.y = $window.height-(@image.height/5)-10

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
    if self.x >= 510
      self.destroy
    end

    @tick+=1
    self.x+=0.8 if @move

    if @move && @tick >= rand(10..15)
      next_image
      @tick = 0
    end
  end
end
