class Film
  class Scene
    attr_accessor :objects, :active, :instance

    def initialize
      @objects = []
      @instance = self
      @active = false
      $window.scenes << self
    end

    def cleanup
      @objects = []
    end

    def draw
      @objects.each(&:draw)
    end

    def update
      @objects.each(&:update)
    end

    def gosu_time
      ($global_tick-@gosu_time)
    end

    def button_down?(id)
      $window.button_down?(id)
    end
  end
end
