require "spec_helper"

  describe Kele do
    it "has a version number" do
      expect(Kele::VERSION).not_to be nil
    end

     it "raises an error with invalid credentials" do
       expect {Kele::Kele.new("test@fake.com", "12345")}.to raise_error(RuntimeError, 'Invalid Credentials')
     end

  end
