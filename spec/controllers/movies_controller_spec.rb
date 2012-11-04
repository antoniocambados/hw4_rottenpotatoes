require 'spec_helper'

describe MoviesController do
  describe 'Find movies with same director' do
    it 'should call the model method that finds the movies given a director' do
      fake_movie = {:title => 'A Fake Movie', :rating => 'PG', :release_date => 10.years.ago}
      fake_movie = Movie.create!(fake_movie)
      #Movie.stub(:find).and_return(fake_movie)
      # We set the expectation of calling 'find_all_by_director' with the
      # argument 'George Lucas'
      Movie.should_receive(:related_movies).with(fake_movie.id)
      # And we trigger the route with the expected params to check if the
      # expectations are accomplished.
      get :director, {:id => fake_movie.id}
    end
    it 'should render the correct view template' do
      # We don't care if the method exists or works fine, so we redefine it
      Movie.stub(:related_movies)
      # We trigger the route with the expected params
      get :director, {:id => 1}
      # And we ensure the right template is rendered
      response.should render_template('director')
    end
    it 'should make the found movies available to that template' do
      # We set some mock objects, which are the expected result of the action
      fake_results = [mock('Movie'), mock('Movie')]
      # We redefine the method so if it ever gets called, it returns the
      # expected results
      Movie.stub(:related_movies).and_return(fake_results)
      # We trigger the route with the expected params
      get :director, {:id => 1}
      # And we verify the view has the 'movies' variable, which equals our mocks
      assigns(:movies).should == fake_results
    end
  end
end
