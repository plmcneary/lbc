require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Lush Bull City"
    assert_equal full_title("Help"), "Help | Lush Bull City"
  end
end
