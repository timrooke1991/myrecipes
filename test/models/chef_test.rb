require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "James", email: "james@gmail.com")
  end
  
  test "Chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname length should not be too long" do 
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname length should not be too short" do 
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end
  
  test "email should be present" do 
    @chef.email = " "
    assert_not @chef.valid?
  end 
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@gmail.com"
    assert_not @chef.valid?
  end
  
  test "email address unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end  
  
  test "email validity - acceptance" do 
    valid_addresses = %w[user@eee.com R_TDD_DS@eee.hello.org example@example.co.uk first.last@eee.au lauraoe@monk.cm]
    valid_addresses.each do |va|
        @chef.email = va
        assert @chef.valid?, '#{ va.inspect } should be valid'
      end
  end
  
  test "email validity - rejection" do 
    invalid_addresses = %w[useeee.com R_TDD-DSateee.hello.org example@example first.last_at_eee.au laura@joe@monk.cm]
    invalid_addresses.each do |ia|
        @chef.email = ia
        assert_not @chef.valid?, '#{ ia.inspect } should be invalid'
      end
  end
  
  
end