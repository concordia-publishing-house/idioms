require "test_helper"

class RangeInBatchesOfTest < Minitest::Test

  context "#in_batches_of" do
    should "break a range into subranges of the specified size" do
      assert_equal [0...4, 4...8], (0...8).in_batches_of(4).to_a
    end

    should "return a partial range that matches the original range's exclusivity if there's a remainder" do
      assert_equal [0...4, 4...8, 8...10], (0...10).in_batches_of(4).to_a
      assert_equal [0...4, 4...8, 8..10], (0..10).in_batches_of(4).to_a
    end
  end

end
