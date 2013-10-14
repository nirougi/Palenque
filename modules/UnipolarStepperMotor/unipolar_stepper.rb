class UnipolarStepper

    attr_accessor :pins, :currentPin, :speed, :spinning, :rotating

    def initialize pins = nil, speed = 0.5
        
        @pins = []
        pins.each_with_index do |pin, key|
          @pins[key] =  PiPiper::Pin.new(pin: pin, direction: :out)
        end

        @currentPin = 0
        @spinning = false
        @rotating = false
        @speed = speed
    end

    # Rolling

    def rotate degrees = 0, speed = self.speed

        steps = degrees.to_i / 1
        i = self.currentPin
        self.rotating = true

        if degrees.to_i > 0
            for a in 0..steps

                n = i/2
                n.to_i
                sleep speed

                if i == 0
                    pins[3].off
                    i = i+1
                elsif i == 7
                    pins[0].on
                    i = 0
                elsif i%2 == 0 
                    pins[n-1].off
                    i = i+1
                else
                    pins[n+1].on
                    i = i+1
                end
            end

        elsif degrees.to_i < 0

            steps = steps * -1
            for a in 0..steps

                n = i/2
                n.to_i
                sleep speed

                if i == 0
                    pins[3].on
                    i = 7
                elsif i == 7
                    pins[0].off
                    i = i-1
                elsif i%2 == 0 
                    pins[n-1].on
                    i = i-1
                else
                    pins[n+1].off
                    i = i-1
                end
            end
        end

        self.rotating = false
        self.currentPin = i
    end

    def spin direction = 1, speed = self.speed
        if direction == 1 or direction == -1
            puts direction
            self.spinning = true
            while self.spinning == true
                self.rotate direction, speed
                sleep speed
            end
        end
    end

    def stop 
        self.spinning = false
    end

    #status

    def is_rotating?
       return self.rotating
    end

    def is_spinning?
        return self.spinning
    end

end