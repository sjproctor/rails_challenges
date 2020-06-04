# Rails Routes Controllers Views

### Challenges

For each section below, generate a new controller to handle the methods, routes, and views.

**Joke... again ;)**
- As a user, I can go to the url 'localhost:3000/question' and be asked a joke

$ rails g controller question
Remove unnecessary files

Add controller method
```
class QuestionController < ApplicationController
  def joke_setup
    render html: "Why did the chicken cross the road?"
  end
end
```

Add route
```
get '/question' => 'question#joke_setup'
```

- As a user, I can go to the url 'localhost:3000/answer' and see the response to the joke.

$ rails g controller answer
Remove unnecessary files

Add a controller method
```
class AnswerController < ApplicationController
  def joke_punchline
    render html: "To get to the other side."
  end
end
```

Add route
```
get '/answer' => 'answer#joke_punchline'
```



2) Recommendations
As a user, I can see a page called 'localhost:3000/places' that lists you and your partner's top 10 places to see in San Diego.
As a user, I can see a page called 'localhost:3000/television' that lists you and your partner's top 10 TV Shows.
As a user, I can see a page called 'localhost:3000/team' and see a list of the team members who built this application.
As a user, I can see your team page when I visit 'localhost:3000'.

3) Links
- As a user, I can visit a landing page that has a link to my joke.
Add a file in *app/views/question*
As a user, when I am on my joke page, I can click a link that will take me to the page with the answer.
As a user, I can visit the landing page and see links to all recommendation lists.
As a user, I can return to the landing page from within any of the other pages.
