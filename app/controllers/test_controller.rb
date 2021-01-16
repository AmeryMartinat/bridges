class TestController < ApplicationController
  def index
    test_model = TestModel.find_or_create_by(name: 'test')
    test_model.value = (test_model.value || 0) + 1
    test_model.save!
    render plain: "Test #{test_model.value}"
  end
end
