#!/usr/bin/env ruby

# to do
# -nr flag

def putline(line,width,left,right)
    print left + " "
    print line + " "*(width-line.size)
    print " " + right + "\n"
end

def putming(offset, person)
    cow = [
      "\\   ^__^",
      " \\  (oo)\\_______",
      "    (__)\\       )\\/\\",
      "        ||----w |",
      "        ||     ||"
    ]
    ming = [
      "\\     ___",
      " \\   /    \\",
      "  \\ |`[][]-|",
      "    |  __  |",
      "     \\    /",
      "     /----\\"
    ]
    nr = [
      "\\    nnnnnn",
      " \\  (|~  _|)",
      "  \\ (-[][]-)",
      "    (| __ |)",
      "    ((uuuu))",
      "    ( )  ( )",
      "    ( )  ( )",
    ]
    if (person == "-nr")
      nr.each do |line|
        puts " "*offset + line
      end
    elsif (person == "-cow")
      cow.each do |line|
        puts " "*offset + line
      end
    else
      ming.each do |line|
        puts " "*offset + line
      end
    end
end

def draw(text, option)
  if (text.size==1)
    width = text[0].size
    puts " " + "_"*(width+2)
    puts "< " + text[0] + " >"
    puts " " + "-"*(width+2)
  else
    width = text.map {|x| x.size}.max
    puts " " + "_"*(width+2)
    putline(text[0],width,"/","\\")
    for i in 1..(text.size-2)
        putline(text[i],width,"|","|")
    end
    putline(text[-1],width,"\\","/")
    puts " " + "-"*(width+2)
  end
  putming(10, option)
end

nargs = ARGV.size
if (nargs == 0)
  text = ARGF.read.split("\n")
  draw(text, "-ming")
elsif (nargs == 1)
  option = ARGV.shift
  text = ARGF.read.split("\n")
  draw(text, option)
else
  puts "Usage: echo 'text' | ./mingsay.rb -flag\n"
  puts "Flags: -nr \n"
  puts "       -cow \n"
  puts "       -ming \n"
end


