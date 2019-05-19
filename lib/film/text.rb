class Film
  class Text < Film::Object
    def setup
      # Includes automagical variables from Film::Object
      @image = Gosu::Image.from_text($window, @text, @font, @size)
    end

    def update
      # I guess
    end
  end
end
