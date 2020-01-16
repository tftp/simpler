class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 201
    @headers['Content-Type'] = 'text/plain'
    render plain: 'Plain text'
  end

  def create

  end

  def show


  end

end
