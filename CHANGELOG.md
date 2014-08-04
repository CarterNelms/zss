# Changelog

## July 30, commit 5

  * `mkdir -p app/models` to create the models dir.
  * Created `spec/models/training_path_spec.rb`
  * Moved most validation related spects into the TrainingPath unit specs
  * Created the barest skeleton of the TrainingPath class
  * Added a line to `spec_helper.rb` to require all classes in the `app` directory

Note: We need to discuss `let`s in more detail.

## July 30, commit 4

  * Integration specs for the training paths menu, which compelled us to write
  * Integration specs for creating a training path

Note: The training paths are all expected to fail in this commit.

## July 30, commit 3

  * Commit of shame.  We forgot to smoke test :(

## July 30, commit 2

  * `touch zss`
  * `chmod +x zss`
  * Add shebang to zss
  * Prints Zombie

## July 30, commit 1

  * Copied in Rakefile from the cal project
  * Copied in (and adapted) Gemfile from the cal project
  * Ran bundle, which generated our Gemfile.lock
  * Ran `rspec --init` to generate `.rspec` and `spec/spec_helper.rb`
  * Wrote a basic README
  * Started a CHANGELOG
  * Ran `git init .` to initialize git repo
