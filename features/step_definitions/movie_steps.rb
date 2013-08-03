# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create(movie)
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
	assert page.body.index(e1) < page.body.index(e2)
end

Then /I should see movies in this order: (.*)/ do |movies_string|
	movies_indexes = movies_string.slice(1, movies_string.size - 2).split(/",\s*"/).map{ |movie| page.body.index(movie)}
	assert movies_indexes == movies_indexes.sort
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(/,\s*/).each{|item| step "I #{uncheck}check \"ratings_#{item}\""}
end

Then /I should see all of the movies/ do
	Movie.all.each{|item| step "I should see \"#{item.title}\""}
end

Then /I should( not)? see movies: (.*)/ do |visible, movies_list|
	movies_list.slice(1, movies_list.size - 2).split(/",\s*"/).each{|item| step "I should#{visible} see \"#{item}\"" }
end
