require File.dirname(__FILE__) + '/../test_helper'

class ClientTest < ActiveSupport::TestCase
  fixtures :clients

  # Replace this with your real tests.
  def test_truth
    client = Client.new
    assert !client.valid?
    client.name = 'Alexandre'
    assert client.valid?
  end
end
