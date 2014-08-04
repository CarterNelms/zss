class TrainingPath
  include Comparable

  attr_reader :errors, :id, :name

  def initialize(options)
    @errors = nil
    @name = options[:name]
    @id = options[:id]
  end

  def self.all
    results = []
    Environment.database.execute("SELECT * FROM training_paths").each do |row|
      results << TrainingPath.new(id: row[0], name: row[1])
    end
    results
  end

  def self.count
    Environment.database.execute("SELECT count(id) FROM training_paths")[0][0]
  end
  # SQLITE returns:
  #
  # SELECT count(*) FROM training_paths;
  # [ [ 0 ] ]
  #
  # SELECT * FROM training_paths;
  # [ [1, "Foo"],
  #   [2, "Bar"] ]

  def self.create(options)
    training_path = TrainingPath.new(options)
    training_path.save!
    training_path
  end

  def self.last
    row = Environment.database.execute("SELECT * FROM training_paths ORDER BY id DESC LIMIT 1").last
    if row.nil?
      nil
    else
      #=> [1, "Foo"]
      values = { id: row[0], name: row[1] }
      TrainingPath.new(values)
    end
  end

  def new_record?
    @id.nil?
  end

  def save!
    if valid?
      Environment.database.execute("INSERT INTO training_paths (name) VALUES ('#{@name}')")
      @id = Environment.database.last_insert_row_id
    end
  end

  def skills
    Skill.all("WHERE training_path_id = #{self.id}")
  end

  def valid?
    validate
    @errors.nil?
  end

  def <=>(other)
    self.id <=> other.id
  end

  private

  def validate
    if @name.empty?
      @errors = "Name cannot be blank"
    elsif @name.length >= 30
      @errors = "name must be less than 30 characters"
    elsif @name.match(/^\d+$/)
      @errors = "Name must include letters"
    elsif duplicate_name?
      @errors = "A path with that name already exists"
    else
      @errors = nil
    end
  end

  def duplicate_name?
    records_with_name = Environment.database.execute("SELECT * FROM training_paths WHERE name = '#{@name}'")
    records_with_name.count > 0
  end
end
