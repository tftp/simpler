class TestsController < Simpler::Controller

  def index
    @time = Time.now
    render plain: 'Plain text'
  end

  def create

  end

end
