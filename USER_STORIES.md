Main menu has progress graph (5)
  -> Mark a skill as mastered (3: individually)
    -> View an individual skill (2: individually)
      -> Enter skill descriptions (1: individually)
  -> Import data (4: In Class)
Give user better prompts (6)
Allow users to correct their input (7)

# User Types

* Survival Sherpas: The people writting training paths and their skills
* Students: The people learning/achieving skills

# Stories

## Survival Sherpa enters skill descriptions

As a survival sherpa
In order for my students to actually learn a skill
I want to enter a description when I create a skill

* Note: These would be entered as parting of creating a skill.

## Student views a skill's details

As a student
In order to learn a skill accurately
I want to read details about a skill

Acceptance Criteria:
* Student navigates through training path and selects a skill (via it's display number) to view it's details
* Displays the skill name being worked on
* Displays the skill's description

## Student marks a skill as mastered

As a student
In order to track my progress
I want to mark a skill as mastered

Acceptance Criteria:
* This builds on the skill details screen
* User is prompted with "Have you mastered this skill? y/n"
* Skill mastery is recorded in the achievments model
  * The progress (mastered / not mastered) is stored in the achievments model.
  * The datetime when the skill was finally mastered is stored.
* If a user updates their skill mastery, the existing achievement record is updated.
* If the skill is mastered, instead of being prompted with "Have you mastered this skill?" the user is shown "You mastered this skill on August 14th at 14:40" (or similar).


