class Film
  class Scenes
    class SceneNine < Film::Scene
      def setup
        @tick = 0
        @gosu_time = $global_tick
        @fade_alpha = 255

        @rose_color = Gosu::Color.rgba(251, 96, 127, 254)
        @sky_color = Gosu::Color.rgba(255, 255, 255, 100)

        @fade_color = Gosu::Color.rgba(0, 0, 0, @fade_alpha)

        Plane09.new(image: "assets/planes/scene_05_plane.png", x: $window.width+500, y: $window.height/2-200, z: 10, factor_x: -1.5, factor_y: 1.5)
        15.times do
          num = rand(0..90)
          cloud = "00#{num}" if num >= 10
          cloud = "000#{num}" unless num >= 10
          Film::Cloud09.new(image: "assets/smoke/#{cloud}.png", x: rand($window.width), y: rand($window.height), angle: rand(0..360))
        end
      end

      def draw
        super
        $window.fill_rect(0,0,$window.width,$window.height, @rose_color, -3)
        $window.fill_rect(0,0,$window.width,$window.height, @sky_color, -2)
        $window.fill_rect(0,0,$window.width,$window.height, @fade_color, 25)
      end

      def update
        super
        @fade_color = Gosu::Color.rgba(0, 0, 0, @fade_alpha)


        @tick+=1
        if @tick >= 20
          num = rand(0..90)
          cloud = "00#{num}" if num >= 10
          cloud = "000#{num}" unless num >= 10
          Film::Cloud09.new(image: "assets/smoke/#{cloud}.png", x: -256, y: rand($window.height), angle: rand(0..360))
          @tick = 0
        end

        if self.objects.count >= 150
          self.objects[0..50].each do |object|
            if object.is_a?(Film::Cloud09)
              self.objects.delete(object)
            end
          end
        end


        if ((gosu_time)/1000.0).between?(0.0, 3.0)
          @fade_alpha-=3.1 unless @fade_alpha <= 0
        end

        if (gosu_time)/1000.0 >= 27
          @fade_alpha+=2.1 unless @fade_alpha >= 255
        end

        if (gosu_time)/1000.0 >= 30
          $window.next_scene
        end
      end
    end
  end
end

class Film::Plane09 < Film::Object
  def setup
    @gosu_time = $global_tick
  end

  def update
    super
    self.x-=1
  end
end

class Film
  class Cloud09 < Film::Object
    def setup
      self.center_x = 0.5
      self.center_y = 0.5

      self.z = rand(0..20)
      self.color = Gosu::Color.rgba(255,255,255,200)

      factor = rand(1.0..2.5)
      self.factor_x = factor
      self.factor_y = factor

      @speed = rand(1.0..3.0)
    end

    def update
      super
      self.x+=@speed
    end
  end
end
