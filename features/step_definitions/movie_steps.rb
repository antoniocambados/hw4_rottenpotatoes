# Add a declarative step here for populating the DB with movies.
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should (not )?see "(.*)" before "(.*)"/ do |negative, e1, e2|
  #  page.body is the entire content of the page as a string.
  assert page.body.index(negative ? e2 : e1) < page.body.index(negative ? e1 : e2)
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    if uncheck then
      uncheck("ratings[#{rating}]")
    else
      check("ratings[#{rating}]")
    end
  end
end

# Make it easier to check which ratings are checked and unchecked
Then /^the following ratings should be (un)?checked: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    field_checked = find_field("ratings[#{rating}]")['checked']
    if uncheck then
      assert(!field_checked, "#{rating} should be unchecked")
    else
      assert(field_checked, "#{rating} should be checked")
    end
  end
end

# Determine the number of movies the page is showing
Then /I should see (.*) movies/ do |number|
  assert page.all('table#movies tbody tr').count == number.to_i
end

# Determine the director of a movie
Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  actual_director = Movie.find_by_title(movie).director
  assert( actual_director == director, "Director for '#{movie}' should be #{director} but it's #{actual_director}.")
end
