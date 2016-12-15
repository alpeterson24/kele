module Roadmap
     def get_roadmap(r_id)
         response = self.class.get(
             "/roadmaps/#{r_id}",
             headers: {"authorization" => @auth_token}
         )

         parser(response.body)
     end

     def get_checkpoint(c_id)
         response = self.class.get(
             "/checkpoints/#{c_id}",
             headers: {"authorization" => @auth_token}
         )

         parser(response.body)
     end

end
