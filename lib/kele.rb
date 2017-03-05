require_relative "kele"
require_relative "roadmap"
require 'httparty'

module Kele
     class Kele
         require 'json'
         include HTTParty
         include Roadmap
         base_uri "https://www.bloc.io/api/v1"

         def initialize(email, password)
             auth = {email: email, password: password}

             post_response = self.class.post( "/sessions", body: auth )

             @auth_token = post_response["auth_token"]

             raise "Invalid Credentials" if (!@auth_token)
         end

         def get_me
             response = self.class.get( "/users/me", headers: {"authorization" => @auth_token} )

             parser(response.body)
         end

         def get_mentor_availability(mentor_id)
             response = self.class.get(
                 "/mentors/#{mentor_id}/student_availability",
                 headers: {"authorization" => @auth_token}
             )

             mentor_availability = parser(response.body)
             mentor_availability.map {|time| time if time["booked"] == nil}
         end

         def get_messages(*page)
             raise ArgumentError if page.length > 1
             response = self.class.get(
                 "/message_threads",
                 headers: {"authorization" => @auth_token}
             )

             parser(response.body)
         end

         def create_message(user_id, recipient_id, options={})
             msg_data = {user_id: user_id, recipient_id: recipient_id, subject: options[:subject], "stripped-text" => options[:body]}
             msg_data[:token] = options[:token] if options[:token]

             msg_post_response = self.class.post(
                 "/messages",
                 {headers: {"authorization" => @auth_token},
                 body: msg_data}
             )
             parser(msg_post_response.body)
         end

         def create_submission(enrollment_id, checkpoint_id, options={})
            submission_data = {enrollment_id: enrollment_id, checkpoint_id: checkpoint_id, assignment_branch: options[:branch], assignment_commit_link: options[:link], comment: options[:comment]}

            post_response = self.class.post(
                "/checkpoint_submissions",
                {headers: {"authorization" => @auth_token}, body: submission_data}
            )
            parser(post_response.body)
        end

        private

         def parser(data)
             JSON.parse(data)
         end
      end
 end
