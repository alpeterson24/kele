require_relative "kele"
require 'httparty'

module Kele
     class Kele
         require 'json'
         include HTTParty
         base_uri "https://www.bloc.io/api/v1"

         def initialize(email, password)
             auth = {email: email, password: password}

             post_response = self.class.post( "/sessions", body: auth )

             @auth_token = post_response["auth_token"]

             raise "Invalid Credentials" if (!@auth_token)
         end

         def get_me
             response = self.class.get( "/users/me", headers: {"authorization" => @auth_token} )

             user_data = parser(response.body)
             user_data.each {|key, value| puts "#{key} - #{value}"}
         end

         def get_mentor_availability(m_id)
             response = self.class.get(
                 "/mentors/#{m_id}/student_availability",
                 headers: {"authorization" => @auth_token}
             )

             mentor_availability = parser(response.body)
             mentor_availability.each {|time| puts "#{time} \n" if time["booked"] == nil}
         end

        private

         def parser(data)
             JSON.parse(data)
         end
      end
 end
