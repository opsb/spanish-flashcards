class Tense
  def initialize(opts={})
    @name = opts[:name]
    @conjugations = opts[:conjugations]
  end
  
  def name
    @name
  end
  
  def examples
    @conjugations
  end
end