class Film
  class Scenes
    class SceneFive < Film::Scene
      # Jumping out of plane
      def setup
        Film::Plane05.new(image: "assets/planes/scene_05_plane.png", z: 5)
        @tick = 0
        @gosu_time = $global_tick
        @jumpers = 0
        @last_jump = 20
        @fade_alpha = 255

        20.times do
          num = rand(0..90)
          cloud = "00#{num}" if num >= 10
          cloud = "000#{num}" unless num >= 10
          Film::Cloud.new(image: "assets/smoke/#{cloud}.png", x: rand($window.width), y: rand($window.height), angle: rand(0..360), z: rand(0..6))
        end
      end

      def draw
        super
        # background
        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 25, 254), -2)

        $window.fill_rect(0,0, $window.width,$window.height, Gosu::Color.rgba(0, 0, 0, @fade_alpha), 10)
      end

      def update
        super
        @tick+=1
        @last_jump+=1

        if @tick >= 16
          num = rand(0..90)
          cloud = "00#{num}" if num >= 10
          cloud = "000#{num}" unless num >= 10
          Film::Cloud.new(image: "assets/smoke/#{cloud}.png", x: $window.width+256, y: rand($window.height), angle: rand(0..360), z: rand(0..6))
          @tick = 0
        end

        if self.objects.count >= 150
          self.objects[0..50].each do |object|
            if object.is_a?(Film::Cloud)
              self.objects.delete(object)
            end
          end
        end

        if gosu_time/1000.0 <= 2
          @fade_alpha-=3 unless @fade_alpha <= 0
        end
        if gosu_time/1000.0 >= 20.5 && @jumpers > 7
          @fade_alpha+=2.4
        end

        if gosu_time/1000.0 >= 22 && @jumpers > 7
          $window.next_scene
        end

        spawn_jumper if @tick >= 15 && gosu_time/1000.0 >= 3
      end

      def spawn_jumper
        if @last_jump >= 100 && @jumpers < 8
          @jumpers+=1
          Film::Person05.new(image: "assets/scene_05/person.png", x: $window.width/2-220, y: 70, z: 4)
          @last_jump = 0
        end
      end
    end
  end
end

class Film
  class Plane05 < Film::Object
    def setup
      @tick = 0
      @gosu_time = $global_tick
      self.factor_x = 2.0
      self.factor_y = 2.0
      self.x = $window.width/2-@image.width
      self.y = $window.height/2-@image.height*2+50

      @old_y = self.y
    end

    def update
      # Wait until Jumpers are boarded then move down runway and rotate up and lift off
      @tick+=1

      self.angle+=0.01 unless @tick <= 60
      self.angle-=0.01 unless @tick >= 60 && @tick <= 120
      self.y+=0.2 unless @tick <= 60
      self.y-=0.2 unless @tick >= 60 && @tick <= 120

      @tick = 0 if @tick >= 120
    end
  end
end

class Film
  class Person05 < Film::Object
    def setup
      @tick = 0
      @gosu_time = $global_tick
      @factor = 0.3
      self.factor_x = @factor
      self.factor_y = @factor
    end

    def update
      self.y+=2
      self.x-=0.6

      @tick+=1
    end
  end
end
