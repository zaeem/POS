require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  context "Returns the correct total price for an entire shopping cart based on the per unit prices or the volume prices" do
    Given(:terminal)      { Terminal.create }
    Given(:itemA)         { terminal.setPricing("A", 2.0, 7.0, 4) }
    Given(:itemB)         { terminal.setPricing("B", 12.0) }
    Given(:itemC)         { terminal.setPricing("C", 1.25, 6.0, 6) }
    Given(:itemD)         { terminal.setPricing("D", 0.15) }

    it "Should return $2.00 if item A is scaned" do
      puts "The unit price of item A = #{itemA.unit_price}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("A")

      expect(shopping_cart.result).to eq("$2.00")
    end

    it "Should return $12.00 if item B is scaned" do
      puts "The unit price of item B = #{itemB.unit_price}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("B")

      expect(shopping_cart.result).to eq("$12.00")
    end

    it "Should return $1.25 if item C is scaned" do
      puts "The unit price of item C = #{itemC.unit_price}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("C")

      expect(shopping_cart.result).to eq("$1.25")
    end

    it "Should return $0.15 if item D is scaned" do
      puts "The unit price of item D = #{itemD.unit_price}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("D")

      expect(shopping_cart.result).to eq("$0.15")
    end

    it "Should return error message 'This item doesn't exist.' if item E is scaned" do
      shopping_cart = terminal.shopping_carts.create

      expect(shopping_cart.scan("E")).to eq("This item doesn't exist.")
      expect(shopping_cart.result).to eq("$0.00")
    end

    it "Should return error message 'This item doesn't exist.' if no item is scaned" do
      shopping_cart = terminal.shopping_carts.create

      expect(shopping_cart.scan()).to eq("This item doesn't exist.")
      expect(shopping_cart.result).to eq("$0.00")
    end

    it "Should return $4.00 if item A is scaned two times" do
      puts "The unit price of item A = #{itemA.unit_price}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("A")
      shopping_cart.scan("A")

      expect(shopping_cart.result).to eq("$4.00")
    end

    it "Should return $11.00 if item A is scaned six times($7.00 for 4 and $4.00 for 2)" do
      puts "The unit price of item A = #{itemA.unit_price} and volume price = #{itemA.volume_price} for #{itemA.volume_qty}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")

      expect(shopping_cart.result).to eq("$11.00")
    end

    it "Should return $18.00 if item A is scaned six times($14.00 for 8 and $4.00 for 2)" do
      puts "The unit price of item A = #{itemA.unit_price} and volume price = #{itemA.volume_price} for #{itemA.volume_qty}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")
      shopping_cart.scan("A")

      expect(shopping_cart.result).to eq("$18.00")
    end

    it "Should return $32.40 if items are scanned in this order: ABCDABAA" do
      puts "These are the items of terminal #{itemA.code}, #{itemB.code}, #{itemC.code}, #{itemD.code}"
      shopping_cart = terminal.shopping_carts.create
      shopping_cart.scan("A")
      shopping_cart.scan("B")
      shopping_cart.scan("C")
      shopping_cart.scan("D")
      shopping_cart.scan("A")
      shopping_cart.scan("B")
      shopping_cart.scan("A")
      shopping_cart.scan("A")

      expect(shopping_cart.result).to eq("$32.40")
    end

    it "Should return $7.25 if items are scanned in this order: CCCCCCC" do
      puts "These are the items of terminal #{itemA.code}, #{itemB.code}, #{itemC.code}, #{itemD.code}"
      shopping_cart = terminal.shopping_carts.create!
      shopping_cart.scan("C")
      shopping_cart.scan("C")
      shopping_cart.scan("C")
      shopping_cart.scan("C")
      shopping_cart.scan("C")
      shopping_cart.scan("C")
      shopping_cart.scan("C")

      expect(shopping_cart.result).to eq("$7.25")
    end

    it "Should return $15.40 if items are scanned in this order: ABCD" do
      puts "These are the items of terminal #{itemA.code}, #{itemB.code}, #{itemC.code}, #{itemD.code}"
      shopping_cart = terminal.shopping_carts.create!
      shopping_cart.scan("A")
      shopping_cart.scan("B")
      shopping_cart.scan("C")
      shopping_cart.scan("D")

      expect(shopping_cart.result).to eq("$15.40")
    end

  end
end
