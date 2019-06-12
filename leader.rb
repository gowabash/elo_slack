class Leader
  def initialize
    @playas = []
    Dir.foreach('.') do |playa|
      match = playa.match(/(.*).elo$/)
      next unless match
      @playas << Elo::Player.load(match[1])
    end
  end

  def board
    @playas.sort!{|a,b| b.rating <=> a.rating}
    @playas.each {|p| puts "<#{p.name}> - #{p.rating}"}
    @playas.map {|p| "<#{p.name}> - #{p.rating}"}.join("\n")
  end

  private 
end
