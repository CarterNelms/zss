RSpec.describe TrainingPath do
  context ".all" do
    context "with no training paths in the database" do
      it "should return an empty array" do
        expect(TrainingPath.all).to eq []
      end
    end
    context "with several training paths in the database" do
      let!(:foo){ TrainingPath.create(name: "Foo") }
      let!(:bar){ TrainingPath.create(name: "bar") }
      let!(:grille){ TrainingPath.create(name: "grille") }

      it "should return all of the training paths" do
        expect(TrainingPath.all).to eq [foo, bar, grille]
      end
    end
  end
  context ".count" do
    it "returns 0 if there are no records" do
      expect(TrainingPath.count).to eq 0
    end
    it "returns the right number if there are records" do
      Environment.database.execute("INSERT INTO training_paths(name) VALUES('Foo')")
        # Expected table state:
        # | name |
        # -------
        # | Foo  |
      Environment.database.execute("INSERT INTO training_paths(name) VALUES('Bar')")
        # Expected table state:
        # | name |
        # -------
        # | Foo  |
        # | Bar  |
      expect(TrainingPath.count).to eq 2
    end
  end

  context ".create" do
    context "with valid data" do
      let!(:training_path){ TrainingPath.create(name: "Knife Skills") }
      it "should not have any errors" do
        expect(training_path.errors).to be_nil
      end
      it "should save the new record" do
        expect(TrainingPath.count).to eq 1
      end
      it "should have saved the values in that record" do
        actual = Environment.database.execute("SELECT name FROM training_paths")
        expected = [["Knife Skills"]]
        expect(actual).to eq expected
      end
      it "should record the id from the database" do
        actual = training_path.id
        expected = Environment.database.execute("SELECT id FROM training_paths")[0][0]
        expect(actual).to eq expected
      end
    end

    context "really long strings" do
      let(:long_string){ "foo" * 12 }
      let!(:training_path){ TrainingPath.create(name: long_string) }

      it "should have an appropriate error message" do
        expect(training_path.errors).to include("name must be less than 30 characters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end

    context "empty string" do
      let!(:training_path){ TrainingPath.create(name: "") }

      it "should have an appropriate error message" do
        expect(training_path.errors).to include("Name cannot be blank")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end

    context "numbers" do
      let!(:training_path){ TrainingPath.create(name: "12") }

      it "should have an appropriate error message" do
        expect(training_path.errors).to include("Name must include letters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end

    context "a duplicate path name" do
      let(:training_path1){ TrainingPath.create(name: "Running") }
      let(:training_path2){ TrainingPath.create(name: "Running") }

      before do
        training_path1
        training_path2
      end

      it "should have an appropriate error message" do
        expect(training_path2.errors).to include("A path with that name already exists")
      end

      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 1
      end
    end
  end
  context ".last" do
    context "if there are no records" do
      it "should return nil" do
        expect(TrainingPath.last).to be_nil
      end
    end
    context "if there is one record" do
      let!(:training_path){ TrainingPath.create(name: "Blunt Weapon Skills") }

      it "should return a record, populated with the correct name" do
        expect(TrainingPath.last.name).to eq "Blunt Weapon Skills"
      end
      it "should return a record, populated with the correct id" do
        expect(TrainingPath.last.id).to eq training_path.id
      end
    end
    context "if there are several records" do
      let(:training_path1){ TrainingPath.create(name: "Foo") }
      let(:training_path2){ TrainingPath.create(name: "Bar") }

      before do
        training_path1
        training_path2
      end

      it "should return the record that was created last, populated with name" do
        expect(TrainingPath.last.name).to eq "Bar"
      end
      it "should return the record that was created last, populated with id" do
        expect(TrainingPath.last.id).to eq training_path2.id
      end
    end
  end
  context "equality" do
    context "the exact same object" do
      it "is true" do
        a = TrainingPath.create(name: "Baz")
        expect(a).to eq a
      end
    end
    context "the same object, as retrieved by the db" do
      it "is true" do
        a = TrainingPath.create(name: "Grille")
        b = TrainingPath.last
        expect(a).to eq b
      end
    end
    context "non-identical objects" do
      it "is false" do
        a = TrainingPath.create(name: "Foo")
        b = TrainingPath.create(name: "Bar")
        expect(a).not_to eq b
      end
    end
  end
  context "#skills" do
    let!(:my_training_path){ TrainingPath.create(name: "Awesome") }
    let!(:other_training_path){ TrainingPath.create(name: "Weevil") }

    context "if there no skills at all" do
      it "returns an empty array" do
        result = my_training_path.skills
        result.should == []
      end
    end
    context "if there are no skills for this training path" do
      before do
        Skill.create(name: "someone else", training_path: other_training_path)
        Skill.create(name: "someone", training_path: other_training_path)
      end
      it "returns an empty array" do
        result = my_training_path.skills
        result.should == []
      end
    end
    context "if there are many skills" do
      let!(:myskill1){ Skill.create(name: "mine!", training_path: my_training_path) }
      let!(:myskill2){ Skill.create(name: "really mine!", training_path: my_training_path) }
      let!(:myskill3){ Skill.create(name: "all mine!", training_path: my_training_path) }

      before do
        Skill.create(name: "someone else", training_path: other_training_path)
        Skill.create(name: "someone", training_path: other_training_path)
      end

      it "returns an the skills for this path" do
        result = my_training_path.skills
        result.should == [myskill1, myskill2, myskill3]
      end
    end
  end
end
