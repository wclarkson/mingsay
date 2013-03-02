#!/usr/bin/env ruby

# to do
# -nr flag

def putline(line,width,left,right)
    print left + " "
    print line + " "*(width-line.size)
    print " " + right + "\n"
end

def putming(offset)
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
    ming.each do |line|
      puts " "*offset + line
    end
end

text = ARGF.read.split("\n")
if (text.size==1)
    puts " " + "_"*(width+2)
    puts "< " + text + " >"
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

putming(10)
