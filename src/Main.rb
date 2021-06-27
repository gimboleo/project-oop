require "io/console"
load "Game.rb"

print(File.read("title.desc"))
STDIN.getch
print "\n\n\n"

g = Game.new
g.play