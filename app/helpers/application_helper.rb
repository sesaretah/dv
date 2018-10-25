module ApplicationHelper
  def ability
    @options = [
      [t(:has), 1],
      [t(:has_not) , 2]
    ]
    return @options
  end

  def existence
    @options = [
      [t(:is_not), 1],
      [t(:is) , 2]
    ]
    return @options
  end

  def rability(s)
    @options = ['has','has_not']
    return @options[s-1]
  end
end
