require 'date'

class Lukija
  def initialize(tiedosto)
    @tiedosto = tiedosto
  end

  def tilasto
    stats = {
      :yhteensa => 0,
      :keskiarvo => 0,
      :alku => nil,
      :loppu => nil
    }
    data = lue

    
    data[:paivat].each do |entry|
      entry = Date.strptime(entry.strip, '%-d.%-m.%y').strftime('%F')
    end
    data[:paivat].sort!
    stats[:alku] = data[:paivat].first
    stats[:loppu] = data[:paivat].last
    
    count = 0
    data[:tunnit].each do |entry|
      entry = entry.strip.chomp('h')
      stats[:yhteensa] += entry.to_f
      count += 1
    end
    stats[:keskiarvo] = stats[:yhteensa] / count.to_f

    stats
  end

  def lue
    lines = IO.readlines(@tiedosto)
    data = {
        :tunnit => Array.new,
        :paivat => Array.new
    }
    
    lines.each do |single|
      data[:paivat].push(single.split(' ')[0])
      data[:tunnit].push(single.split(' ')[1])
    end

    data
  end
end
