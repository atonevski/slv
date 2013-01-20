require 'test_helper'
require 'slv'

class DefaultTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_the_truth
    assert true
  end

  def test_version
    assert SLV::VERSION > '0.0.1', "Version should be > 0.0.1"
  end

  def test_download_pdf
    http = SLV::HTTP.new
    assert_not_nil http.get_issue(Time.now.year, 1)
    assert_nil http.get_issue(Time.now.year, 0)
  end
end
