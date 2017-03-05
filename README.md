# Kele
A Ruby Gem API client to access the Bloc API (from bloc.io).

### Use
With a valid Bloc username and password, use kele to access user information.

* Authenticate and retrieve user token using `Kele.new(username, password)`.
* Retrieve user information (after authenticating).
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_me
```
* Retrieve an authenticated user's mentor's availability (after authenticating).
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_mentor_availability(mentor_id)
```
* Retrieve curriculum roadmaps and checkpoints (after authenticating).
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_roadmap(roadmap_id)
  kele_instance.get_checkpoint(checkpoint_id)
```
* Handle user messages (after authenticating).
```ruby
  kele_instance = Kele.new(username, password)
  kele_instance.get_messages
  # If appending a message to an existing message thread, include the thread token. Otherwise, leave token blank.
  kele_instance.create_message(user_id, recipient_id, subject, message, token)
```

* Handle submissions (after authenticating).
```ruby
  kele_instance = Kele.new(username, password)
  kele_instance.create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
  kele_instance.update_submission(submission_id, assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
```
