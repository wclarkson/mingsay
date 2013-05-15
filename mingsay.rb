#!/usr/bin/env ruby

class Mingsay
    attr_accessor :name, :image, :quote, :quotations

    def initialize(name)
        @name = name
        path = File.expand_path(ENV['MINGSAY_PATH'])
        if !File.directory?(path) then
            puts "No mingsay directory found."
            exit
        end
        begin
            @image = File.open(path+'/people/'+@name, 'r').read
            img_shift = 8
            @image = @image.split("\n").map {|l| " "*img_shift+l}
            @quotations = File.open(path+'/quotations/'+@name, 'r')
                              .read.split("\n\n").map(&:chomp)
        rescue
            puts "No data for specified person found in mingsay directory."
            exit
        end
    end

    def draw_box(text)
        text = text.split("\n").map(&:chomp)
        if (text.size==1) then
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
    end

    def set_quote(quote)
        @quote = quote
    end

    def random_quote()
        @quote = @quotations.sample
    end

    def print()
        draw_box(@quote)
        puts @image
    end
end

m = Mingsay.new('nr')
m.random_quote()
m.print()

