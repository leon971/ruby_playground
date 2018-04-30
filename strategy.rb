

class Isklotine
    attr_accessor :text, :title, :formatter, :suma
   def initialize(title, text, &formatter)
     @title = title
     @text = text || []
     @formatter = formatter
     @suma = 0
   end

   def format_output
     skaiciuok_suma
     @formatter.call(self)
   end

   def skaiciuok_suma
    @suma = 0
     iteration do |tekstas, kaina|
        @suma += kaina.to_i
     end
   end

   def iteration
      @text.each do |tekstas|
        yield tekstas.tekstas, tekstas.kaina
      end
   end
end

irasas = Struct.new(:tekstas, :kaina)
tekstas = []
tekstas << irasas.new('Uz #225', 255)
tekstas << irasas.new('Uz #226', 155)
tekstas << irasas.new('Uz #001', 5)

FORMAT_CEKIS = lambda do |context|
   p Time.now.to_s
   p context.title
   p '******************************************'
   p '                   Sveiki                 '
   p '******************************************'
   p 'Produktas                   | Kaina       '
   p '------------------------------------------'
   context.iteration do |tekstas, suma|
   p "#{tekstas}                  | #{suma}   "   
   end
   p '------------------------------------------'
   p 'Suma:                        ' + context.suma.to_s
   p '------------------------------------------'
end

FORMAT_PLAIN = lambda do |context|
    p context.title
    context.iteration do |tekstas, suma|
        p "#{tekstas}                  | #{suma}   "   
        end
        p 'Suma: ' + context.suma.to_s
end
isklotines = []
isklotines << Isklotine.new('MAXIMA', tekstas, &FORMAT_CEKIS)
isklotines << Isklotine.new('MAXIMA', tekstas, &FORMAT_PLAIN)

isklotines.each do |isklotine|
    isklotine.format_output
end