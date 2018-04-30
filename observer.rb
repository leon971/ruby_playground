class NoImplementationOfInterface < StandardError; end

class ObserversInterface
    def update(value)
        raise NoImplementationOfInterface
    end
end

class Payroll < ObserversInterface
    def update(value)
      puts "Darbuotojui pakelta alga \n"
      puts "Dabar #{value.vardas} alga: " +  value.alga.to_s
    end
end

class Pareigos < ObserversInterface
    def update(value)
    end
end
module Observator
    def initialize
        @observers = []
    end

    def add_observer(value)
        @observers << value
    end

    def delete(value)
        @observers.delete(value)
    end
    
    def notify_observers
        @observers.each do |observer|
            observer.update(self)
        end
    end
end

class Darbuotojas
    include Observator
    attr_accessor :vardas, :pavarde, :alga
    def initialize(vardas, pavarde, alga)
        super()
        @vardas = vardas
        @pavarde = pavarde
        @alga = alga || 100
    end

    def alga=(value)
        @alga = value
        notify_observers
    end
end

darb = Darbuotojas.new('Robertas', 'Rusecki', 200)
pay = Payroll.new
darb.add_observer pay
darb.add_observer Pareigos.new
darb.alga = 250
