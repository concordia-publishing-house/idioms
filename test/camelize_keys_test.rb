require "test_helper"

class CamelizeKeysTest < Minitest::Test
  attr_reader :hash, :new_hash

  context "Given a hash with some non camel-cased keys" do
    setup do
      @hash = {
        "account_id" => 1,
        "productId" => 2,
        :owner_id => 3,
        :companyId => 4,
        5 => 6,
        Object.new => 7,
        "merchant id" => 8
      }

      @new_hash = hash.camelize_keys
    end

    should "convert non-camelcased string keys to camelcase" do
      # accountId
      assert_equal 1, new_hash["accountId"]
      refute new_hash.has_key?("account_id")

      # merchant id
      assert_equal 8, new_hash["merchantId"]
      refute new_hash.has_key?("merchant id")
    end

    should "convert non-camelcased symbol keys to camelcase" do
      assert_equal 3, new_hash[:ownerId]
      refute new_hash.has_key?(:owner_id)
    end

    should "leave camelcased keys and non-string/symbol keys alone" do
      assert new_hash.has_key?("productId")
      assert new_hash.has_key?(:companyId)

      original_hash_object_key = hash.select {|key, value| value == 7}.first[0]
      new_hash_object_key = new_hash.select {|key, value| value == 7}.first[0]

      assert new_hash_object_key
      assert_equal original_hash_object_key.object_id, new_hash_object_key.object_id
    end
  end

end
