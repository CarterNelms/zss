class SkillsController
  def initialize(origin_training_path)
    @origin_training_path = origin_training_path
  end

  def add
    puts "What #{@origin_training_path.name} skill do you want to add?"
    name = clean_gets
    skill = Skill.create(name: name, training_path: @origin_training_path)
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
      puts "#{index + 1}. #{skill.name}"
    end
    Router.navigate_skills_menu(self)
  end
end
