class Film
  class Window < Gosu::Window
    FRAMES = []
    attr_accessor :scenes, :active_scene, :current_scene, :add_new_objects_to_scene, :show_cursor

    def initialize
      if $debug or $render
        super(1280, 720, false)
      else
        # super(Gosu.screen_width, Gosu.screen_height, true) # TODO: fix timings of some scenes at higher res.
        super(1280, 720, true)
      end

      $window = self
      $window.caption = "Untitled Short Film"

      $global_tick = 0#.0

      @scenes = []
      @active_scene = nil # Class instance
      @current_scene = nil # Array index
      @add_new_objects_to_scene = nil # class instance, used by Film::Object to know where to put objects

      @show_cursor = false

      Film::Scenes::Main.new
      Film::Scenes::Intro.new
      Film::Scenes::SceneOne.new
      Film::Scenes::SceneTwo.new
      Film::Scenes::SceneThree.new
      Film::Scenes::SceneFour.new
      Film::Scenes::SceneFive.new
      Film::Scenes::SceneSix.new
      Film::Scenes::SceneSeven.new
      Film::Scenes::SceneEight.new
      Film::Scenes::SceneNine.new
      Film::Scenes::SceneTen.new
      Film::Scenes::SceneEleven.new
      Film::Scenes::Credits.new

      # CONSIDER DROPPING/REMOVING SCENE(s)
      # Film::Scenes::SceneTwelve.new
      # Film::Scenes::SceneThirteen.new


      @current_scene = 0
      set_active_scene(@scenes[@current_scene])
    end

    def set_active_scene(scene)
      raise "Scene is not a Film::Scene instance" unless scene.is_a?(Film::Scene)
      @active_scene.cleanup if @active_scene.is_a?(Film::Scene)
      @active_scene = scene
      scene.setup
    end

    def next_scene
      @current_scene+=1
      set_active_scene(@scenes[@current_scene])
    end

    def prev_scene
      @current_scene-=1
      set_active_scene(@scenes[@current_scene])
    end

    def scene_original
      @scenes.each do |scene|
        scene.objects = []
      end

      @current_scene = -1
      next_scene
    end

    def needs_cursor?
      @show_cursor
    end

    def button_up(id)
      case id
      when Gosu::KbRight
        $window.next_scene if $debug
      when Gosu::KbLeft
        $window.prev_scene if $debug
      when Gosu::KbUp
        $window.scene_original if $debug
      end
    end

    def draw
      @active_scene.draw if @active_scene
    end

    def update
      $global_tick+=16.6667
      self.caption = "Untitled Short Film - #{Gosu.fps} #{Gosu.language} $Tick#{$global_tick}|GTick#{Gosu.milliseconds}" if $render

      if $debug
        self.caption = "Untitled Short Film - #{Gosu.fps} #{Gosu.language} #{Gosu.milliseconds}"
        if button_down?(Gosu::KbEscape)
          exit
        end
      end

      scene = nil
      @scenes.find{|s| scene = s if s.active}
      @active_scene = scene if scene

      @active_scene.update if @active_scene
    end

    def fill_rect(x, y, width, height, color, z = 0, mode = :default)
      return $window.draw_quad(x, y, color,
                               x, height+y, color,
                               width+x, height+y, color,
                               width+x, y, color,
                               z, mode)
    end
  end
end
