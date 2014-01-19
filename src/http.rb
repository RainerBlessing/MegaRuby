class HTTP
  attr_accessor :ds

  # To change this template use File | Settings | File Templates.
  def update_s_time
    self.ds = Time.new
  end
end