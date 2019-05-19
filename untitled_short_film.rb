require "gosu"

require_relative "lib/film/window"
require_relative "lib/film/scene"
require_relative "lib/film/object"
require_relative "lib/film/text"

require_relative "lib/film/scenes"
require_relative "lib/film/scenes/main"
require_relative "lib/film/scenes/intro"

# ACT One
require_relative "lib/film/scenes/scene_01"   # Living room
require_relative "lib/film/scenes/scene_02"   # Photo
require_relative "lib/film/scenes/scene_03"   # Boarding plane. Plane taking off
require_relative "lib/film/scenes/scene_04"   # Plane, flying
require_relative "lib/film/scenes/scene_05" # Para-jumpers jumping out if plane
require_relative "lib/film/scenes/scene_06" # Para-jumpers landing

# ACT Two
require_relative "lib/film/scenes/scene_07" # Para-jumpers getting shot at, brothers die
require_relative "lib/film/scenes/scene_08" # brothers being carried onto plane
require_relative "lib/film/scenes/scene_09" # plane flying back

# ACT Three
require_relative "lib/film/scenes/scene_10" # plane landing
require_relative "lib/film/scenes/scene_11" # Brothers being carried off plane, Mother collapses to the ground with a hand on each coffin
require_relative "lib/film/scenes/scene_12" # photo of Brothers grave
require_relative "lib/film/scenes/scene_13" # zoom out into living room

require_relative "lib/film/scenes/credits"    # Roll credits

$debug = true if ARGV.to_s.include?("--debug")

Film::Window.new.show
