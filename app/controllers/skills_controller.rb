class SkillsController
  def initialize(origin_training_path)
    @origin_training_path = origin_training_path
  end

  def add
    puts "What #{@origin_training_path.name} skill do you want to add?"
    name = clean_gets
    puts "Describe #{name}:"
    description = clean_gets
    skill = Skill.create(name: name, training_path: @origin_training_path, description: description)
    if skill.new_record?
      puts skill.errors
    else
      puts "#{name} has been added to the #{@origin_training_path.name} training path"
    end
  end

  def list
    puts "=============="
    puts "#{@origin_training_path.name.upcase} SKILLS"
    puts "=============="
    @origin_training_path.skills.each_with_index do |skill, index|
      puts "#{index + 1}. #{skill.name}#{skill.mastered? ? ' - MASTERED' : ''}"
    end
    Router.navigate_skills_menu(self)
  end

  def view(skill_number)
    skill = skills[skill_number - 1]
    if skill
      puts "#{skill.name}:\n#{skill.description}"
      master(skill)
    else
      puts "Sorry, skill #{skill_number} doesn't exist."
    end
  end

  def skills
    @origin_training_path.skills
  end

  def master(skill)
    if skill.mastered?
      puts "You mastered this skill on #{skill.mastered_on}"
    else
      puts "Have you mastered this skill? (y/N)"
      is_mastered = (clean_gets).downcase
      skill.master if is_mastered == 'y'
    end
  end
end
