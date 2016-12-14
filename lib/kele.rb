require_relative "kele"
require 'httparty'

module Kele
     class Kele
         include HTTParty
         base_uri "https://www.bloc.io/api/v1"

         def initialize(email, password)
             @auth = {email: email, password: password}

             post_response = self.class.post(
                 "/sessions",
                 body: @auth
             )

             @auth_token = post_response.body["auth_token"]

             raise "Invalid Credentials" if (!@auth_token)
         end
      end
 end
